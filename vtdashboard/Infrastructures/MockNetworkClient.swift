import Combine

class MockNetworkClient: NetworkClientProtocol {
    func get<T: Codable>(endpoint: Endpoint) -> Future<T, Error> {
        switch endpoint {
        case .getChannelList:
            fatalError("Not implemented")
        @unknown default:
            fatalError("URL Not found")
        }
    }
}
