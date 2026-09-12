import Foundation
import AppKit

class PetServer {
    static let shared = PetServer()
    let port: UInt16 = 18920
    private var serverFD: Int32 = -1
    private var running = false
    private var serverQueue = DispatchQueue(label: "com.menupet.server", qos: .userInitiated)

    private var appDelegate: AppDelegate? {
        NSApp.delegate as? AppDelegate
    }

    func start() {
        guard !running else { return }

        serverFD = socket(AF_INET, SOCK_STREAM, 0)
        guard serverFD >= 0 else {
            print("PetServer: Failed to create socket")
            return
        }

        var reuse: Int32 = 1
        setsockopt(serverFD, SOL_SOCKET, SO_REUSEADDR, &reuse, socklen_t(MemoryLayout<Int32>.size))

        var addr = sockaddr_in()
        addr.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        addr.sin_family = sa_family_t(AF_INET)
        addr.sin_port = port.bigEndian
        addr.sin_addr.s_addr = INADDR_ANY

        let bindResult = withUnsafePointer(to: &addr) { ptr in
            ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockPtr in
                bind(serverFD, sockPtr, socklen_t(MemoryLayout<sockaddr_in>.size))
            }
        }

        guard bindResult == 0 else {
            print("PetServer: Failed to bind to port \(port) - \(String(cString: strerror(errno)))")
            close(serverFD)
            serverFD = -1
            return
        }

        guard listen(serverFD, 16) == 0 else {
            print("PetServer: Failed to listen")
            close(serverFD)
            serverFD = -1
            return
        }

        running = true
        print("PetServer: Listening on port \(port)")

        serverQueue.async { [weak self] in
            self?.acceptLoop()
        }

        registerBonjour()
    }

    func stop() {
        running = false
        if serverFD >= 0 {
            close(serverFD)
            serverFD = -1
        }
    }

    private func acceptLoop() {
        while running {
            var clientAddr = sockaddr_in()
            var addrLen = socklen_t(MemoryLayout<sockaddr_in>.size)
            let clientFD = withUnsafeMutablePointer(to: &clientAddr) { ptr in
                ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockPtr in
                    accept(serverFD, sockPtr, &addrLen)
                }
            }
            guard clientFD >= 0 else {
                if running { continue }
                break
            }
            let fd = clientFD
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.handleClient(fd)
            }
        }
    }

    private func handleClient(_ fd: Int32) {
        var buffer = [UInt8](repeating: 0, count: 65536)
        let bytesRead = read(fd, &buffer, buffer.count)
        guard bytesRead > 0 else {
            close(fd)
            return
        }

        guard let request = String(bytes: buffer[..<bytesRead], encoding: .utf8) else {
            sendRawResponse(fd: fd, status: 400, json: ["error": "Invalid request"])
            close(fd)
            return
        }

        let lines = request.components(separatedBy: "\r\n")
        guard let firstLine = lines.first else {
            sendRawResponse(fd: fd, status: 400, json: ["error": "Empty request"])
            close(fd)
            return
        }

        let parts = firstLine.split(separator: " ")
        guard parts.count >= 2 else {
            sendRawResponse(fd: fd, status: 400, json: ["error": "Malformed request"])
            close(fd)
            return
        }

        let method = String(parts[0])
        let path = String(parts[1])

        var requestBody: [String: Any] = [:]
        if let bodyRange = request.range(of: "\r\n\r\n") {
            let bodyString = String(request[bodyRange.upperBound...])
            if let bodyData = bodyString.data(using: .utf8),
               let json = try? JSONSerialization.jsonObject(with: bodyData) as? [String: Any] {
                requestBody = json
            }
        }

        let result = routeSync(method: method, path: path, body: requestBody)

        if let jsonData = result.data {
            sendRawData(fd: fd, status: result.status, contentType: result.contentType ?? "application/json", data: jsonData)
        } else {
            sendRawResponse(fd: fd, status: result.status, json: result.body ?? [:])
        }
        close(fd)
    }

    private func routeSync(method: String, path: String, body: [String: Any]) -> (status: Int, body: [String: Any]?, data: Data?, contentType: String?) {
        let pet = PetState.shared
        var character: SelectableCharacter = .pokemon(.pikachu)
        DispatchQueue.main.sync {
            if let app = self.appDelegate {
                character = app.spriteAnimator.currentPokemon
            }
        }

        switch (method, path) {
        case ("GET", "/pet/state"):
            let state: [String: Any] = [
                "character": character.identifier,
                "displayName": character.displayName,
                "category": character.category,
                "emoji": character.emoji,
                "hunger": Int(pet.hunger),
                "happiness": Int(pet.happiness),
                "energy": Int(pet.energy),
                "hygiene": Int(pet.hygiene),
                "careScore": Int(pet.careScore),
                "stage": pet.stage,
                "stageName": pet.stageName,
                "mood": pet.mood,
                "moodEmoji": pet.moodEmoji,
                "isDisobedient": pet.isDisobedient,
                "obedience": Int(pet.obedience)
            ]
            return (200, state, nil, nil)

        case ("GET", "/pet/sprite"):
            var pngData: Data?
            DispatchQueue.main.sync {
                if let app = self.appDelegate {
                    let image = app.spriteAnimator.currentFrame
                    if let tiffData = image.tiffRepresentation,
                       let bitmap = NSBitmapImageRep(data: tiffData) {
                        pngData = bitmap.representation(using: .png, properties: [:])
                    }
                }
            }
            if let data = pngData {
                return (200, nil, data, "image/png")
            } else {
                return (500, ["error": "Failed to render sprite"], nil, nil)
            }

        case ("POST", "/pet/feed"):
            DispatchQueue.main.sync { pet.feed(personality: character.personality) }
            LLMService.shared.invalidateCache()
            return (200, ["ok": true, "hunger": Int(pet.hunger)], nil, nil)

        case ("POST", "/pet/play"):
            DispatchQueue.main.sync { pet.play(personality: character.personality) }
            LLMService.shared.invalidateCache()
            return (200, ["ok": true, "happiness": Int(pet.happiness)], nil, nil)

        case ("POST", "/pet/clean"):
            DispatchQueue.main.sync { pet.clean() }
            LLMService.shared.invalidateCache()
            return (200, ["ok": true, "hygiene": Int(pet.hygiene)], nil, nil)

        case ("POST", "/pet/sleep"):
            DispatchQueue.main.sync { pet.sleep() }
            LLMService.shared.invalidateCache()
            return (200, ["ok": true, "energy": Int(pet.energy)], nil, nil)

        case ("POST", "/pet/chat"):
            guard let message = body["message"] as? String else {
                return (400, ["error": "Missing message"], nil, nil)
            }
            let chatMessages = (body["history"] as? [[String: String]] ?? []) + [["role": "user", "content": message]]
            let group = DispatchGroup()
            var chatResult: Result<String, Error>?
            group.enter()
            LLMService.shared.chat(character: character, messages: chatMessages) { result in
                chatResult = result
                group.leave()
            }
            group.wait()
            switch chatResult {
            case .success(let response):
                return (200, ["response": response], nil, nil)
            case .failure(let error):
                return (500, ["error": error.localizedDescription], nil, nil)
            case .none:
                return (500, ["error": "No response"], nil, nil)
            }

        case ("GET", "/pet/llm-status"):
            let status = LLMService.shared.getCachedStatus(for: character) ?? ""
            return (200, ["status": status], nil, nil)

        case ("GET", "/pet/ping"):
            return (200, ["pong": true, "version": "1.0.0"], nil, nil)

        default:
            return (404, ["error": "Not found"], nil, nil)
        }
    }

    private func sendRawResponse(fd: Int32, status: Int, json: [String: Any]) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return
        }
        let header = "HTTP/1.1 \(status) OK\r\nContent-Type: application/json\r\nContent-Length: \(jsonString.utf8.count)\r\nConnection: close\r\nAccess-Control-Allow-Origin: *\r\n\r\n"
        if let headerData = header.data(using: .utf8) {
            var fullData = headerData
            fullData.append(jsonData)
            _ = fullData.withUnsafeBytes { ptr in
                write(fd, ptr.baseAddress!, ptr.count)
            }
        }
    }

    private func sendRawData(fd: Int32, status: Int, contentType: String, data: Data) {
        let header = "HTTP/1.1 \(status) OK\r\nContent-Type: \(contentType)\r\nContent-Length: \(data.count)\r\nConnection: close\r\nAccess-Control-Allow-Origin: *\r\n\r\n"
        if let headerData = header.data(using: .utf8) {
            var fullData = headerData
            fullData.append(data)
            _ = fullData.withUnsafeBytes { ptr in
                write(fd, ptr.baseAddress!, ptr.count)
            }
        }
    }

    private func registerBonjour() {
        let netService = NetService(domain: "local.", type: "_menupet._tcp.", name: "MenuPet", port: Int32(port))
        netService.publish()
    }
}
