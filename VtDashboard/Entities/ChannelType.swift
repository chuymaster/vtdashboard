enum ChannelType: Int, Codable {
    case original = 1
    case half = 2

    var displayText: String {
        switch self {
        case .original:
            return "Original"
        case .half:
            return "Half"
        }
    }
}
