import Foundation

struct Channel: Identifiable, Codable {
    var id: String { channelId }
    let channelId: String
    let title: String
    let thumbnailImageUrl: String
    let type: ChannelType
    let updatedAt: TimeInterval
    
    lazy var updatedAtLabel: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: Date(timeIntervalSince1970: updatedAt))
    }()
}
