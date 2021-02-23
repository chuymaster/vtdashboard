import Combine
import SwiftUI

final class ChannelRequestsViewModel: ViewStatusManageable, ObservableObject {
    @Published var viewStatus: ViewStatus = .loading
    @Published var channelRequests: [ChannelRequest] = []
    
    private let networkClient: NetworkClientProtocol
    
    private var cancellable: AnyCancellable?
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
        getChannelRequests()
    }
    
    func getChannelRequests() {
        cancellable?.cancel()
        viewStatus = .loading
        cancellable = networkClient.get(endpoint: .getChannelRequestList)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.viewStatus = .loaded
                case .failure(let error):
                    self?.viewStatus = .error(error: error)
                }
            } receiveValue: { [weak self] channelRequests in
                self?.channelRequests = channelRequests
            }
    }
}
