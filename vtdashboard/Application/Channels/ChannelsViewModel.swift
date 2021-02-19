import Combine
import SwiftUI

final class ChannelsViewModel: ObservableObject {
    @Published var channels: [Channel] = []
    @Published var error: Error?
    @Published private(set) var isLoading = false
    
    private let networkClient: NetworkClientProtocol
    
    private var cancellable: AnyCancellable?
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
        getChannels()
    }
    
    func getChannels() {
        cancellable?.cancel()
        isLoading = true
        cancellable = networkClient.get(endpoint: .getChannelList)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    self?.error = nil
                case .failure(let error):
                    self?.error = error
                }
            } receiveValue: { [weak self] channels in
                self?.channels = channels
            }
    }
}
