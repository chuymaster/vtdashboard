import Foundation

struct Channel: Identifiable {
    let id: String
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

let dummyChannels: [Channel] = [
    .init(
        id: "UC7iCSRt7Jej2XE0MaM9gPgg",
        title: "YuChan Channel",
        thumbnailImageUrl: "https://yt3.ggpht.com/ytc/AAUvwngABpVP2Dh5kziMwBubM3LoBbn9G813luZ-1HqS=s240-c-k-c0x00ffffff-no-rj",
        type: .original,
        updatedAt: 1613646011196
    ),
    .init(
        id: "UC3HM8L5j53x0WsliGNTXhbQ",
        title: "Shanaru Ch.",
        thumbnailImageUrl: "https://yt3.ggpht.com/ytc/AAUvwngV0-gmlgzNNWds0My5lISTZ5Bh3kk-5_iYehd0Sw=s240-c-k-c0x00ffffff-no-rj",
        type: .half,
        updatedAt: 1613646011189
    )
]
