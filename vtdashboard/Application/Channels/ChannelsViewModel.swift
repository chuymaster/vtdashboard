import Combine
import SwiftUI

final class ChannelsViewModel: ObservableObject {
    @Published var viewStatus: ViewStatus = .loading
    @Published var channels: [Channel] = []
    
    private let networkClient: NetworkClientProtocol
    
    private var cancellable: AnyCancellable?
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
        getChannels()
    }
    
    func getChannels() {
        cancellable?.cancel()
        viewStatus = .loading
        cancellable = networkClient.get(endpoint: .getChannelList)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.viewStatus = .loaded
                case .failure(let error):
                    self?.viewStatus = .error(error: error)
                }
            } receiveValue: { [weak self] channels in
                self?.channels = channels
            }
    }
}
