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
        let rawPath = String(parts[1])

        var path = rawPath
        var queryParams: [String: String] = [:]
        if let qIdx = rawPath.firstIndex(of: "?") {
            path = String(rawPath[..<qIdx])
            let queryString = String(rawPath[rawPath.index(after: qIdx)...])
            for pair in queryString.components(separatedBy: "&") {
                let kv = pair.components(separatedBy: "=")
                if kv.count == 2 {
                    queryParams[kv[0]] = kv[1].removingPercentEncoding ?? kv[1]
                }
            }
        }

        if method == "OPTIONS" {
            sendRawResponse(fd: fd, status: 200, json: ["ok": true])
            close(fd)
            return
        }

        var requestBody: [String: Any] = [:]
        if let bodyRange = request.range(of: "\r\n\r\n") {
            let bodyString = String(request[bodyRange.upperBound...])
            if let bodyData = bodyString.data(using: .utf8),
               let json = try? JSONSerialization.jsonObject(with: bodyData) as? [String: Any] {
                requestBody = json
            }
        }

        let result = routeSync(method: method, path: path, body: requestBody, queryParams: queryParams)

        if let jsonData = result.data {
            sendRawData(fd: fd, status: result.status, contentType: result.contentType ?? "application/json", data: jsonData)
        } else {
            sendRawResponse(fd: fd, status: result.status, json: result.body ?? [:])
        }
        close(fd)
    }

    private func routeSync(method: String, path: String, body: [String: Any], queryParams: [String: String] = [:]) -> (status: Int, body: [String: Any]?, data: Data?, contentType: String?) {
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
                "disobedienceMessage": pet.disobedienceMessage ?? "",
                "obedience": Int(pet.obedience),
                "timestamp": Date().timeIntervalSince1970
            ]
            return (200, state, nil, nil)

        case ("GET", "/pet/status"):
            var statusMsg = ""
            DispatchQueue.main.sync {
                if let app = self.appDelegate {
                    statusMsg = app.spriteAnimator.llmStatus ?? ""
                }
            }
            return (200, ["status": statusMsg], nil, nil)

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

        case ("GET", "/pet/frames"):
            let targetH = Double(queryParams["height"] ?? "160") ?? 160
            var frames: [[String: Any]] = []
            DispatchQueue.main.sync {
                if let app = self.appDelegate {
                    let images = app.spriteAnimator.renderAllFramesHighRes(targetHeight: CGFloat(targetH))
                    for (i, image) in images.enumerated() {
                        if let tiffData = image.tiffRepresentation,
                           let bitmap = NSBitmapImageRep(data: tiffData),
                           let pngData = bitmap.representation(using: .png, properties: [:]) {
                            frames.append(["index": i, "base64": pngData.base64EncodedString()])
                        }
                    }
                }
            }
            return (200, ["frames": frames, "fps": 2, "count": frames.count], nil, nil)

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

        case ("POST", "/pet/discipline"):
            var message = ""
            DispatchQueue.main.sync { message = pet.discipline() }
            LLMService.shared.invalidateCache()
            return (200, ["ok": true, "message": message, "isDisobedient": pet.isDisobedient, "obedience": Int(pet.obedience)], nil, nil)

        case ("POST", "/pet/chat"):
            guard let message = body["message"] as? String else {
                return (400, ["error": "Missing message"], nil, nil)
            }
            let chatMessages = (body["history"] as? [[String: String]] ?? []) + [["role": "user", "content": message]]
            let semaphore = DispatchSemaphore(value: 0)
            var chatResult: Result<String, Error>?
            LLMService.shared.chat(character: character, messages: chatMessages) { result in
                chatResult = result
                semaphore.signal()
            }
            _ = semaphore.wait(timeout: .now() + 35)
            switch chatResult {
            case .success(let response):
                return (200, ["response": response], nil, nil)
            case .failure(let error):
                return (500, ["error": error.localizedDescription], nil, nil)
            case .none:
                return (500, ["error": "Timeout"], nil, nil)
            }

        case ("POST", "/pet/sync"):
            let remoteHunger = body["hunger"] as? Double
            let remoteHappiness = body["happiness"] as? Double
            let remoteEnergy = body["energy"] as? Double
            let remoteHygiene = body["hygiene"] as? Double
            let remoteTimestamp = body["timestamp"] as? TimeInterval ?? 0
            let localTimestamp = pet.lastModified

            if remoteTimestamp > localTimestamp {
                if let h = remoteHunger { pet.hunger = min(100, max(0, h)) }
                if let hp = remoteHappiness { pet.happiness = min(100, max(0, hp)) }
                if let e = remoteEnergy { pet.energy = min(100, max(0, e)) }
                if let hy = remoteHygiene { pet.hygiene = min(100, max(0, hy)) }
            }

            LLMService.shared.invalidateCache()
            let state: [String: Any] = [
                "hunger": Int(pet.hunger),
                "happiness": Int(pet.happiness),
                "energy": Int(pet.energy),
                "hygiene": Int(pet.hygiene),
                "timestamp": Date().timeIntervalSince1970,
                "character": character.identifier
            ]
            return (200, state, nil, nil)

        case ("GET", "/pet/llm-status"):
            let status = LLMService.shared.getCachedStatus(for: character) ?? ""
            return (200, ["status": status], nil, nil)

        case ("GET", "/pet/all"):
            let targetH = Double(queryParams["height"] ?? "160") ?? 160
            let renderer = SpriteRenderer()
            var pets: [[String: Any]] = []
            DispatchQueue.main.sync {
                let manager = MultiPetManager.shared
                if manager.selectedPets.isEmpty {
                    var singlePet: [String: Any] = [
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
                        "disobedienceMessage": pet.disobedienceMessage ?? "",
                        "obedience": Int(pet.obedience),
                        "isPrimary": true
                    ]
                    let images = (self.appDelegate?.spriteAnimator ?? nil) != nil
                        ? self.appDelegate!.spriteAnimator.renderAllFramesHighRes(targetHeight: CGFloat(targetH))
                        : (0..<4).map { renderer.renderFrameHighRes(character: character, frame: $0, targetHeight: CGFloat(targetH)) }
                    var frames: [[String: Any]] = []
                    for (i, image) in images.enumerated() {
                        if let tiffData = image.tiffRepresentation,
                           let bitmap = NSBitmapImageRep(data: tiffData),
                           let pngData = bitmap.representation(using: .png, properties: [:]) {
                            frames.append(["index": i, "base64": pngData.base64EncodedString()])
                        }
                    }
                    singlePet["frames"] = frames
                    pets.append(singlePet)
                } else {
                    for (idx, selChar) in manager.selectedPets.enumerated() {
                        let s = manager.state(for: selChar)
                        var petData: [String: Any] = [
                            "character": selChar.identifier,
                            "displayName": selChar.displayName,
                            "category": selChar.category,
                            "emoji": selChar.emoji,
                            "hunger": Int(s.hunger),
                            "happiness": Int(s.happiness),
                            "energy": Int(s.energy),
                            "hygiene": Int(s.hygiene),
                            "careScore": Int(s.careScore),
                            "stage": s.stage,
                            "stageName": s.stageName,
                            "mood": s.mood,
                            "moodEmoji": s.moodEmoji,
                            "isDisobedient": s.isDisobedient,
                            "disobedienceMessage": s.disobedienceMessage ?? "",
                            "obedience": Int(s.obedience),
                            "isPrimary": idx == 0
                        ]
                        var frames: [[String: Any]] = []
                        if idx == 0, let animator = self.appDelegate?.spriteAnimator {
                            let images = animator.renderAllFramesHighRes(targetHeight: CGFloat(targetH))
                            for (i, image) in images.enumerated() {
                                if let tiffData = image.tiffRepresentation,
                                   let bitmap = NSBitmapImageRep(data: tiffData),
                                   let pngData = bitmap.representation(using: .png, properties: [:]) {
                                    frames.append(["index": i, "base64": pngData.base64EncodedString()])
                                }
                            }
                        } else {
                            let images = (0..<4).map { renderer.renderFrameHighRes(character: selChar, frame: $0, targetHeight: CGFloat(targetH)) }
                            for (i, image) in images.enumerated() {
                                if let tiffData = image.tiffRepresentation,
                                   let bitmap = NSBitmapImageRep(data: tiffData),
                                   let pngData = bitmap.representation(using: .png, properties: [:]) {
                                    frames.append(["index": i, "base64": pngData.base64EncodedString()])
                                }
                            }
                        }
                        petData["frames"] = frames
                        pets.append(petData)
                    }
                }
            }
            return (200, ["pets": pets, "count": pets.count], nil, nil)

        case ("GET", "/pet/ping"):
            return (200, ["pong": true, "version": "1.1.0"], nil, nil)

        default:
            return (404, ["error": "Not found"], nil, nil)
        }
    }

    private func sendRawResponse(fd: Int32, status: Int, json: [String: Any]) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return
        }
        let statusText: String
        switch status {
        case 200: statusText = "OK"
        case 400: statusText = "Bad Request"
        case 404: statusText = "Not Found"
        case 500: statusText = "Internal Server Error"
        default: statusText = "OK"
        }
        let header = "HTTP/1.1 \(status) \(statusText)\r\nContent-Type: application/json\r\nContent-Length: \(jsonString.utf8.count)\r\nConnection: close\r\nAccess-Control-Allow-Origin: *\r\nAccess-Control-Allow-Methods: GET, POST, OPTIONS\r\nAccess-Control-Allow-Headers: Content-Type\r\n\r\n"
        if let headerData = header.data(using: .utf8) {
            var fullData = headerData
            fullData.append(jsonData)
            _ = fullData.withUnsafeBytes { ptr in
                write(fd, ptr.baseAddress!, ptr.count)
            }
        }
    }

    private func sendRawData(fd: Int32, status: Int, contentType: String, data: Data) {
        let header = "HTTP/1.1 \(status) OK\r\nContent-Type: \(contentType)\r\nContent-Length: \(data.count)\r\nConnection: close\r\nAccess-Control-Allow-Origin: *\r\nAccess-Control-Allow-Methods: GET, POST, OPTIONS\r\nAccess-Control-Allow-Headers: Content-Type\r\n\r\n"
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
