import Cocoa

extension Notification {
    func isSimulator() -> Bool {
        guard let app = self.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication else {
            return false
        }
        let bundleId = app.bundleIdentifier ?? ""
        return bundleId == SIMULATOR_BUNDLE_ID
            || (bundleId.contains("Xcode") && bundleId.contains("Previews"))
    }

    func getSimulatorPID() -> pid_t? {
        guard let app = self.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication else {
            return nil
        }
        return app.processIdentifier
    }
}
