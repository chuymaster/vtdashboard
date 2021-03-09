import Foundation

struct ChannelStatisticsResult: Codable {
    var result: [[ChannelStatistics]]
}
struct ChannelStatistics: Identifiable, Codable {
    var id: String { channelId }
    let channelId: String
    let title: String
    let description: String
    let thumbnailIconUrl: String
    let subscribers: Int?
    let views: Int?
    let comments: Int?
    let videos: Int?
    let uploads: String
    let publishedAt: String
    let lastPublishedVideoAt: String
    let updatedAt: TimeInterval
    let isRebranded: Bool
    
    var type: ChannelType {
        isRebranded ? .half : .original
    }
    
    var url: URL {
        URL(string: "https://youtube.com/channel/\(channelId)")!
    }
}
