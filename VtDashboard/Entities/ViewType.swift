enum ViewType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case channelRequests = "Channel Requests"
    case channels = "Channels"
    case addChannel = "Add Channel Request"
    case settings = "Settings"
    case login = "Login"

    var iconImageName: String {
        switch self {
        case .channels:
            return "person.2.fill"
        case .channelRequests:
            return "person.crop.circle.fill.badge.plus"
        case .addChannel:
            return "pencil.tip.crop.circle.badge.plus"
        case .settings:
            return "wrench.and.screwdriver.fill"
        case .login:
            return "key.fill"
        }
    }
}
