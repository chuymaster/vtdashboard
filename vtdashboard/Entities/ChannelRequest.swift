import Foundation

struct ChannelRequest: Identifiable, Codable {
    var id: String { channelId }
    let channelId: String
    let title: String
    let thumbnailImageUrl: String
    var type: ChannelType
    var status: ChannelRequestStatus
    let updatedAt: TimeInterval
}
