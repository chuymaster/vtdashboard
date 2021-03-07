import Foundation

struct Channel: Identifiable, Codable {
    var id: String { channelId }
    let channelId: String
    let title: String
    let thumbnailImageUrl: String
    var type: ChannelType
    let updatedAt: TimeInterval
}
