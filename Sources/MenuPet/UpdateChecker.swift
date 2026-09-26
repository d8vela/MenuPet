import Foundation
import AppKit
import Security

enum UpdateCheckResult {
    case upToDate
    case updateAvailable(version: String, downloadURL: String)
    case failed(String)
}

class UpdateChecker {
    static let shared = UpdateChecker()

    private let repoOwner = "d8vela"
    private let repoName = "MenuPet"
    private let releasesURL = "https://api.github.com/repos/d8vela/MenuPet/releases/latest"
    private let expectedBundleID = "com.menupet.MenuPet"

    private var downloadSession: URLSession?
    private var downloadDelegate: DownloadDelegate?

    private init() {}

    var currentVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    static func isAllowedDownloadURL(_ url: URL) -> Bool {
        guard url.scheme?.lowercased() == "https" else { return false }
        guard let host = url.host?.lowercased() else { return false }
        switch host {
        case "github.com":
            return url.path.lowercased().hasPrefix("/\(shared.repoOwner.lowercased())/\(shared.repoName.lowercased())/")
        case "objects.githubusercontent.com",
             "github-releases.githubusercontent.com",
             "release-assets.githubusercontent.com":
            return true
        default:
            return false
        }
    }

    func checkForUpdates(completion: @escaping (UpdateCheckResult) -> Void) {
        guard let url = URL(string: releasesURL) else {
            DispatchQueue.main.async { completion(.failed("Update check URL is invalid.")) }
            return
        }

        var request = URLRequest(url: url, timeoutInterval: 30)
        request.setValue("MenuPet/\(currentVersion)", forHTTPHeaderField: "User-Agent")
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }

            let result: UpdateCheckResult
            if let error = error {
                result = .failed("Failed to check for updates: \(error.localizedDescription)")
            } else if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
                result = .failed("GitHub returned HTTP \(http.statusCode).")
            } else if let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let tagName = json["tag_name"] as? String {
                let latestVersion = self.normalizedVersion(tagName)
                if self.isVersion(latestVersion, newerThan: self.normalizedVersion(self.currentVersion)) {
                    let downloadURL = self.findDMGDownloadURL(in: json)
                    if let parsed = URL(string: downloadURL), Self.isAllowedDownloadURL(parsed) {
                        result = .updateAvailable(version: latestVersion, downloadURL: downloadURL)
                    } else {
                        result = .failed("A newer version was found, but its download URL is not a GitHub release asset.")
                    }
                } else {
                    result = .upToDate
                }
            } else {
                result = .failed("Invalid response from GitHub.")
            }

            DispatchQueue.main.async { completion(result) }
        }.resume()
    }

    private func normalizedVersion(_ raw: String) -> String {
        var version = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        if let first = version.first, first == "v" || first == "V" {
            version.removeFirst()
        }
        return version
    }

    private func findDMGDownloadURL(in json: [String: Any]) -> String {
        guard let assets = json["assets"] as? [[String: Any]] else { return "" }

        for asset in assets {
            if let name = asset["name"] as? String,
               name.lowercased().hasSuffix(".dmg"),
               let browserDownloadURL = asset["browser_download_url"] as? String {
                return browserDownloadURL
            }
        }
        return ""
    }

    func isVersion(_ newer: String, newerThan current: String) -> Bool {
        let newParts = newer.split(separator: ".").map { Int($0) ?? 0 }
        let currentParts = current.split(separator: ".").map { Int($0) ?? 0 }

        for i in 0..<max(newParts.count, currentParts.count) {
            let newPart = i < newParts.count ? newParts[i] : 0
            let currentPart = i < currentParts.count ? currentParts[i] : 0

            if newPart > currentPart { return true }
            if newPart < currentPart { return false }
        }
        return false
    }

    func downloadAndInstallUpdate(from urlString: String, progressWindow: NSWindow? = nil, progressIndicator: NSProgressIndicator? = nil, statusLabel: NSTextField? = nil) {
        guard let url = URL(string: urlString), Self.isAllowedDownloadURL(url) else {
            DispatchQueue.main.async {
                progressWindow?.close()
                self.showError("The update download URL is invalid or not from GitHub.")
            }
            return
        }

        downloadSession?.invalidateAndCancel()

        let delegate = DownloadDelegate(progressIndicator: progressIndicator, statusLabel: statusLabel)
        downloadDelegate = delegate

        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.name = "MenuPet.UpdateDownload"

        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: queue)
        downloadSession = session

        delegate.onComplete = { [weak self] fileURL, error in
            guard let self = self else { return }
            session.finishTasksAndInvalidate()

            if let error = error {
                DispatchQueue.main.async {
                    progressWindow?.close()
                    self.showError("Download failed: \(error.localizedDescription)")
                }
                return
            }

            guard let fileURL = fileURL else {
                DispatchQueue.main.async {
                    progressWindow?.close()
                    self.showError("Download failed: No data received")
                }
                return
            }

            DispatchQueue.main.async {
                statusLabel?.stringValue = "Installing..."
                progressIndicator?.isIndeterminate = true
                progressIndicator?.startAnimation(nil)
            }

            let installError = self.installUpdate(from: fileURL)
            DispatchQueue.main.async {
                progressWindow?.close()
                if let installError = installError {
                    self.showError(installError)
                } else {
                    self.restartApp()
                }
            }
        }

        session.downloadTask(with: url).resume()
    }

    /// Returns an error message, or nil when the running bundle was replaced.
    private func installUpdate(from dmgPath: URL) -> String? {
        let mountPoint = dmgPath.deletingLastPathComponent().appendingPathComponent("MenuPetMount")
        let attach = Process()
        attach.executableURL = URL(fileURLWithPath: "/usr/bin/hdiutil")
        attach.arguments = ["attach", dmgPath.path, "-mountpoint", mountPoint.path, "-nobrowse", "-quiet"]

        do {
            try? FileManager.default.removeItem(at: mountPoint)
            try attach.run()
            attach.waitUntilExit()
            guard attach.terminationStatus == 0 else {
                return "Failed to mount the update."
            }
        } catch {
            return "Failed to mount the update: \(error.localizedDescription)"
        }

        defer {
            let detach = Process()
            detach.executableURL = URL(fileURLWithPath: "/usr/bin/hdiutil")
            detach.arguments = ["detach", mountPoint.path, "-quiet", "-force"]
            if (try? detach.run()) != nil {
                detach.waitUntilExit()
            }
            try? FileManager.default.removeItem(at: dmgPath.deletingLastPathComponent())
        }

        let appInDMG = mountPoint.appendingPathComponent("MenuPet.app")
        if let validationError = validateUpdateBundle(at: appInDMG) {
            return validationError
        }

        let appPath = Bundle.main.bundleURL
        let incoming = appPath.deletingLastPathComponent().appendingPathComponent("MenuPet.app.new")
        do {
            try? FileManager.default.removeItem(at: incoming)
            try FileManager.default.copyItem(at: appInDMG, to: incoming)
            _ = try FileManager.default.replaceItemAt(appPath, withItemAt: incoming)
        } catch {
            try? FileManager.default.removeItem(at: incoming)
            return "Failed to replace the app: \(error.localizedDescription)"
        }

        return nil
    }

    private func validateUpdateBundle(at bundleURL: URL) -> String? {
        let executable = bundleURL.appendingPathComponent("Contents/MacOS/MenuPet")
        guard FileManager.default.fileExists(atPath: bundleURL.path),
              FileManager.default.isExecutableFile(atPath: executable.path) else {
            return "The download did not contain MenuPet.app."
        }

        let plistURL = bundleURL.appendingPathComponent("Contents/Info.plist")
        guard let info = NSDictionary(contentsOf: plistURL) as? [String: Any],
              let bundleID = info["CFBundleIdentifier"] as? String,
              bundleID == (Bundle.main.bundleIdentifier ?? expectedBundleID) else {
            return "The update is not MenuPet."
        }

        let currentTeam = signingTeamID(of: Bundle.main.bundleURL)
        let newTeam = signingTeamID(of: bundleURL)
        let newIsSigned = isValidlySigned(bundleURL)

        if let currentTeam = currentTeam {
            guard newIsSigned, newTeam == currentTeam else {
                return "The update is not signed by the same developer as this app."
            }
        }

        return nil
    }

    private func signingTeamID(of bundleURL: URL) -> String? {
        var staticCode: SecStaticCode?
        guard SecStaticCodeCreateWithPath(bundleURL as CFURL, [], &staticCode) == errSecSuccess,
              let staticCode else { return nil }

        var info: CFDictionary?
        guard SecCodeCopySigningInformation(staticCode, SecCSFlags(rawValue: kSecCSSigningInformation), &info) == errSecSuccess,
              let dict = info as? [String: Any] else { return nil }

        return dict[kSecCodeInfoTeamIdentifier as String] as? String
    }

    private func isValidlySigned(_ bundleURL: URL) -> Bool {
        var staticCode: SecStaticCode?
        guard SecStaticCodeCreateWithPath(bundleURL as CFURL, [], &staticCode) == errSecSuccess,
              let staticCode else { return false }
        return SecStaticCodeCheckValidity(staticCode, SecCSFlags(rawValue: kSecCSStrictValidate), nil) == errSecSuccess
    }

    private func restartApp() {
        let alert = NSAlert()
        alert.messageText = "Update Installed"
        alert.informativeText = "MenuPet will now restart to apply the update."
        alert.addButton(withTitle: "Restart Now")
        alert.addButton(withTitle: "Restart Later")

        if alert.runModal() == .alertFirstButtonReturn {
            let appPath = Bundle.main.bundlePath
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/usr/bin/open")
            process.arguments = [appPath]
            try? process.run()

            NSApplication.shared.terminate(nil)
        }
    }

    private func showError(_ message: String) {
        let alert = NSAlert()
        alert.messageText = "Update Error"
        alert.informativeText = message
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

class DownloadDelegate: NSObject, URLSessionDownloadDelegate {
    private weak var progressIndicator: NSProgressIndicator?
    private weak var statusLabel: NSTextField?
    private var finished = false

    var onComplete: ((URL?, Error?) -> Void)?

    init(progressIndicator: NSProgressIndicator?, statusLabel: NSTextField?) {
        self.progressIndicator = progressIndicator
        self.statusLabel = statusLabel
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        if let url = request.url, UpdateChecker.isAllowedDownloadURL(url) {
            completionHandler(request)
        } else {
            completionHandler(nil)
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard !finished else { return }
        finished = true

        if let http = downloadTask.response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            onComplete?(nil, downloadError("GitHub returned HTTP \(http.statusCode)."))
            return
        }

        let dest = FileManager.default.temporaryDirectory
            .appendingPathComponent("MenuPetUpdate", isDirectory: true)
            .appendingPathComponent("MenuPet.dmg")
        do {
            try FileManager.default.createDirectory(at: dest.deletingLastPathComponent(), withIntermediateDirectories: true)
            try? FileManager.default.removeItem(at: dest)
            try FileManager.default.copyItem(at: location, to: dest)
            onComplete?(dest, nil)
        } catch {
            onComplete?(nil, error)
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard !finished, let error = error else { return }
        finished = true
        onComplete?(nil, error)
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async {
            guard totalBytesExpectedToWrite > 0 else {
                self.progressIndicator?.isIndeterminate = true
                self.progressIndicator?.startAnimation(nil)
                self.statusLabel?.stringValue = "Downloading..."
                return
            }
            let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite) * 100
            self.progressIndicator?.isIndeterminate = false
            self.progressIndicator?.doubleValue = progress
            self.statusLabel?.stringValue = "\(Int(progress))%"
        }
    }

    private func downloadError(_ message: String) -> NSError {
        NSError(domain: "MenuPet.Update", code: 1, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
