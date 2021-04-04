import Combine

// swiftlint:disable force_cast
struct MockNetworkClient: NetworkClientProtocol {
    func post<T>(endpoint: PostEndpoint, parameters: [String: String]) -> Future<T, Error> where T: Decodable, T: Encodable {
        switch endpoint {
        case .postChannelRequest:
            return Future { promise in
                let channelRequest = ChannelRequest(
                    channelId: "UCicCFumqJgPj23vkAh_1TbA",
                    title: "BubbleGum - TH - Vtuber _Maid Cafe_",
                    thumbnailImageUrl: "https://yt3.ggpht.com/ytc/AAUvwnhmhwnVvT9NHI2aOaaHo8NElvdf_WdO819fTFuW=s800-c-k-c0x00ffffff-no-rj",
                    type: .original,
                    status: .accepted,
                    updatedAt: 1613949914670
                )
                promise(.success(channelRequest as! T))
            }
        default:
            fatalError("not yet implemented")
        }
    }

    func get<T: Codable>(endpoint: GetEndpoint) -> Future<T, Error> {
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
        case .getChannelRequestList:
            return Future { promise in
                let channelRequests: [ChannelRequest] = [
                    .init(
                        channelId: "UCicCFumqJgPj23vkAh_1TbA",
                        title: "BubbleGum - TH - Vtuber _Maid Cafe_",
                        thumbnailImageUrl: "https://yt3.ggpht.com/ytc/AAUvwnhmhwnVvT9NHI2aOaaHo8NElvdf_WdO819fTFuW=s800-c-k-c0x00ffffff-no-rj",
                        type: .original,
                        status: .accepted,
                        updatedAt: 1613949914670
                    ),
                    .init(
                        channelId: "UC6Q4UI5mEjeZOIRoTtRoFJA",
                        title: "Midnight Ch. / มิดไนท์",
                        thumbnailImageUrl: "https://yt3.ggpht.com/ytc/AAUvwnh-9J0m6X4RJslG02wUBKkVCSlds_9FulEbf4iI=s800-c-k-c0x00ffffff-no-rj",
                        type: .half,
                        status: .unconfirmed,
                        updatedAt: 1613274214285
                    )
                ]
                promise(.success(channelRequests as! T))
            }
        case .getChannelDataList:
            return Future { promise in
                let data: [[ChannelStatistics]] = [
                    [
                        .init(
                            channelId: "UCqhhWjpw23dWhJ5rRwCCrMA",
                            title: "Aisha Channel",
                            description: "Guppa! Virtual Idol Aisha is here! \nMeet Aisha's enjoyable video contents here! ♡ (~￣▽￣)~\n---------\nสวัสดีค่ะ ไอช่า Virtual Idol มาแล้วค่า!\nพบกับเรื่องราวสนุกสนานเฮฮาแบบฉบับของไอช่า\nได้ที่นี่เลยน้า เย้! ♡ (~￣▽￣)~",
                            thumbnailIconUrl: "https://yt3.ggpht.com/ytc/AAUvwniQOl0Xy77wbhbcYRHdDzBflm5ZvHUTNgZiFO_EQg=s240-c-k-c0x00ffffff-no-rj",
                            subscribers: 279000,
                            views: 20000000,
                            comments: nil,
                            videos: 261,
                            uploads: "UUqhhWjpw23dWhJ5rRwCCrMA",
                            publishedAt: "2019-07-12T10:32:09Z",
                            lastPublishedVideoAt: "2021-03-06T07:37:14Z",
                            updatedAt: 1615287606826,
                            isRebranded: false
                        )
                    ]
                ]
                promise(.success(data as! T))
            }
        }
    }
}
