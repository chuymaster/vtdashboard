enum UserDefaultsKey: String {
    case serverEnvironment
    
    var values: [String] {
        switch self {
        case .serverEnvironment:
            return ServerEnvironmentValue.allCases.map { $0.rawValue }
        }
    }
}

enum ServerEnvironmentValue: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case development
    case production
}
