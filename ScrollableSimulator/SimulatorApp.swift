import Cocoa

let SIMULATOR_BUNDLE_ID = "com.apple.iphonesimulator"

// Xcode Previews runs its own simulator process whose bundle identifier
// contains both "Xcode" and "Previews". Include it so scrolling also works
// when using SwiftUI previews.

class SimulatorApp {
    static func getSimulatorPID() -> pid_t? {
        if let app = NSWorkspace.shared.runningApplications
            .first(where: { $0.bundleIdentifier == SIMULATOR_BUNDLE_ID }) {
            return app.processIdentifier
        }
        // When using SwiftUI previews the simulator is launched inside
        // Xcode. Look for applications whose bundle identifier includes
        // "Xcode" and "Previews" to support this case.
        if let app = NSWorkspace.shared.runningApplications
            .first(where: { app in
                guard let id = app.bundleIdentifier else { return false }
                return id.contains("Xcode") && id.contains("Previews")
            }) {
            return app.processIdentifier
        }
        return nil
    }
}
