import Foundation
import AppKit

class UpdateChecker {
    static let shared = UpdateChecker()
    
    private let repoOwner = "d8vela"
    private let repoName = "MenuPet"
    private let releasesURL = "https://api.github.com/repos/d8vela/MenuPet/releases/latest"
    
    var onUpdateAvailable: ((String, String) -> Void)?
    var onCheckComplete: ((Bool, String?) -> Void)?
    
    private init() {}
    
    var currentVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    
    func checkForUpdates() {
        guard let url = URL(string: releasesURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.onCheckComplete?(false, "Failed to check for updates: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let tagName = json["tag_name"] as? String else {
                DispatchQueue.main.async {
                    self.onCheckComplete?(false, "Invalid response from GitHub")
                }
                return
            }
            
            let latestVersion = tagName.replacingOccurrences(of: "v", with: "")
            
            if self.isVersion(latestVersion, newerThan: self.currentVersion) {
                let downloadURL = self.findDMGDownloadURL(in: json)
                DispatchQueue.main.async {
                    self.onUpdateAvailable?(latestVersion, downloadURL)
                    self.onCheckComplete?(true, "Update available: v\(latestVersion)")
                }
            } else {
                DispatchQueue.main.async {
                    self.onCheckComplete?(false, "You're up to date! (v\(self.currentVersion))")
                }
            }
        }
        task.resume()
    }
    
    private func findDMGDownloadURL(in json: [String: Any]) -> String {
        guard let assets = json["assets"] as? [[String: Any]] else { return "" }
        
        for asset in assets {
            if let name = asset["name"] as? String,
               name.hasSuffix(".dmg"),
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
    
    func downloadAndInstallUpdate(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let tempDir = FileManager.default.temporaryDirectory.appendingPathComponent("MenuPetUpdate")
        try? FileManager.default.removeItem(at: tempDir)
        try? FileManager.default.createDirectory(at: tempDir, withIntermediateDirectories: true)
        
        let dmgPath = tempDir.appendingPathComponent("MenuPet.dmg")
        
        DispatchQueue.main.async {
            NSWorkspace.shared.notificationCenter.post(name: .downloadStarted, object: nil)
        }
        
        let task = URLSession.shared.downloadTask(with: url) { [weak self] tempURL, response, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.showError("Download failed: \(error.localizedDescription)")
                }
                return
            }
            
            guard let tempURL = tempURL else {
                DispatchQueue.main.async {
                    self.showError("Download failed: No data received")
                }
                return
            }
            
            do {
                try FileManager.default.moveItem(at: tempURL, to: dmgPath)
                self.installUpdate(from: dmgPath)
            } catch {
                DispatchQueue.main.async {
                    self.showError("Failed to save update: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    private func installUpdate(from dmgPath: URL) {
        let mountPoint = dmgPath.deletingLastPathComponent().appendingPathComponent("MenuPetMount")
        
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/hdiutil")
        process.arguments = ["attach", dmgPath.path, "-mountpoint", mountPoint.path, "-nobrowse", "-quiet"]
        
        do {
            try process.run()
            process.waitUntilExit()
            
            guard process.terminationStatus == 0 else {
                DispatchQueue.main.async {
                    self.showError("Failed to mount DMG")
                }
                return
            }
            
            let appInDMG = mountPoint.appendingPathComponent("MenuPet.app")
            let appPath = Bundle.main.bundleURL
            
            let cpProcess = Process()
            cpProcess.executableURL = URL(fileURLWithPath: "/bin/cp")
            cpProcess.arguments = ["-R", appInDMG.path, appPath.deletingLastPathComponent().path]
            
            try cpProcess.run()
            cpProcess.waitUntilExit()
            
            let detachProcess = Process()
            detachProcess.executableURL = URL(fileURLWithPath: "/usr/bin/hdiutil")
            detachProcess.arguments = ["detach", mountPoint.path, "-quiet"]
            try? detachProcess.run()
            detachProcess.waitUntilExit()
            
            try? FileManager.default.removeItem(at: dmgPath.deletingLastPathComponent())
            
            DispatchQueue.main.async {
                self.restartApp()
            }
        } catch {
            DispatchQueue.main.async {
                self.showError("Failed to install update: \(error.localizedDescription)")
            }
        }
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

extension Notification.Name {
    static let downloadStarted = Notification.Name("downloadStarted")
    static let downloadProgress = Notification.Name("downloadProgress")
}
