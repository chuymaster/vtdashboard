import Foundation

enum GetEndpoint {
    
    private static let baseURL = URL(string: "https://us-central1-thaivtuberranking-dev.cloudfunctions.net/")!
    
    case getChannelList
    case getChannelRequestList
    
    var url: URL {
        switch self {
        case .getChannelList:
            return GetEndpoint.baseURL.appendingPathComponent("getChannelList")
        case .getChannelRequestList:
            return GetEndpoint.baseURL.appendingPathComponent("getChannelRequestList")
        }
    }
}

enum PostEndpoint {
    private static let baseURL = URL(string: "https://us-central1-thaivtuberranking-dev.cloudfunctions.net/")!
    
    case postChannelRequest
    case postChannel
    case deleteChannel
    
    var url: URL {
        switch self {
        case .postChannelRequest:
            return PostEndpoint.baseURL.appendingPathComponent("postChannelRequest")
        case .postChannel:
            return PostEndpoint.baseURL.appendingPathComponent("postChannel")
        case .deleteChannel:
            return PostEndpoint.baseURL.appendingPathComponent("deleteChannel")
        }
    }
}
