import Foundation
import SwiftUI

struct Endpoint {
    @AppStorage(UserDefaultsKey.serverEnvironment.rawValue) private static var serverEnvironment: ServerEnvironmentValue = .development
    
    static var baseURL: URL {
        switch serverEnvironment {
        case .development:
            return URL(string: "https://us-central1-thaivtuberranking-dev.cloudfunctions.net/")!
        case .production:
            return URL(string: "https://us-central1-thaivtuberranking.cloudfunctions.net/")!
        }
    }
}

enum GetEndpoint {
    case getChannelList
    case getChannelRequestList
    
    var url: URL {
        switch self {
        case .getChannelList:
            return Endpoint.baseURL.appendingPathComponent("getChannelList")
        case .getChannelRequestList:
            return Endpoint.baseURL.appendingPathComponent("getChannelRequestList")
        }
    }
}

enum PostEndpoint {
    case postChannelRequest
    case postChannel
    case deleteChannel
    
    var url: URL {
        switch self {
        case .postChannelRequest:
            return Endpoint.baseURL.appendingPathComponent("postChannelRequest")
        case .postChannel:
            return Endpoint.baseURL.appendingPathComponent("postChannel")
        case .deleteChannel:
            return Endpoint.baseURL.appendingPathComponent("deleteChannel")
        }
    }
}
