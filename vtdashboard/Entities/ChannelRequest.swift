import Foundation

struct ChannelRequest: Identifiable, Codable {
    var id: String { channelId }
    let channelId: String
    let title: String
    let thumbnailImageUrl: String
    let type: ChannelType
    let status: ChannelRequestStatus
    let updatedAt: TimeInterval
}
