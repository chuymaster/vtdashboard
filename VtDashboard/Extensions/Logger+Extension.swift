import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let auth = Logger(subsystem: subsystem, category: "auth")
    static let network = Logger(subsystem: subsystem, category: "network")
    static let local = Logger(subsystem: subsystem, category: "local")
}
