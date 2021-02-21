import Combine

// swiftlint:disable force_cast
struct MockNetworkClient: NetworkClientProtocol {
    func get<T: Codable>(endpoint: Endpoint) -> Future<T, Error> {
        switch endpoint {
        case .getChannelList:
            return Future { promise in
                let channels: [Channel] = [
                    .init(
                        channelId: "UC7iCSRt7Jej2XE0MaM9gPgg",
                        title: "YuChan Channel",
                        thumbnailImageUrl: "https://yt3.ggpht.com/ytc/AAUvwngABpVP2Dh5kziMwBubM3LoBbn9G813luZ-1HqS=s240-c-k-c0x00ffffff-no-rj",
                        type: .original,
                        updatedAt: 1613646011196
                    ),
                    .init(
                        channelId: "UC3HM8L5j53x0WsliGNTXhbQ",
                        title: "Shanaru Ch.",
                        thumbnailImageUrl: "https://yt3.ggpht.com/ytc/AAUvwngV0-gmlgzNNWds0My5lISTZ5Bh3kk-5_iYehd0Sw=s240-c-k-c0x00ffffff-no-rj",
                        type: .half,
                        updatedAt: 1613646011189
                    )
                ]
                promise(.success(channels as! T))
            }
        @unknown default:
            fatalError("URL Not found")
        }
    }
}
