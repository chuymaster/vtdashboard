enum UserDefaultsKey: String {
    case serverEnvironment
    case channelsSortType

    var values: [String] {
        switch self {
        case .serverEnvironment:
            return ServerEnvironmentValue.allCases.map { $0.rawValue }
        default:
            return []
        }
    }
}

enum ServerEnvironmentValue: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case development
    case production
    
    var googleServiceInfoFileName: String {
        switch self {
        case .development:
            return "GoogleService-Info-Development"
        case .production:
            return "GoogleService-Info-Production"
        }
    }
}
