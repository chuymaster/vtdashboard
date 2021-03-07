import SwiftUI

enum ChannelRequestStatus: Int, Codable {
    case unconfirmed = 1
    case accepted = 2
    case pending = 3
    case rejected = 4
    
    var displayText: String {
        switch self {
        case .unconfirmed:
            return "Unconfirmed"
        case .accepted:
            return "Accepted"
        case .pending:
            return "Pending"
        case .rejected:
            return "Rejected"
        }
    }
    var backgroundColor: Color {
        switch self {
        case .unconfirmed:
            return .blue
        case .accepted:
            return .green
        case .pending:
            return .orange
        case .rejected:
            return .gray
        }
    }
}
