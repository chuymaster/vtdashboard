import Foundation

struct Channel: Identifiable, Codable {
    var id: String { channelId }
    let channelId: String
    let title: String
    let thumbnailImageUrl: String
    var type: ChannelType
    let updatedAt: TimeInterval
    var statistics: ChannelStatistics?

    var url: URL {
        URL(string: "https://youtube.com/channel/\(channelId)")!
    }
}
