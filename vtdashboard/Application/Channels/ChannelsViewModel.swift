import Combine
import SwiftUI

final class ChannelsViewModel: ObservableObject {
    @Published var channels: [Channel] = []
    @Published var error: Error?
    @Published private(set) var isLoading = false
    
    private let url = "https://us-central1-thaivtuberranking.cloudfunctions.net/getChannelList"
    
    private var cancellable: AnyCancellable?
    
    init() {
        getChannels()
    }
    
    func getChannels() {
        cancellable?.cancel()
        isLoading = true
        cancellable = NetworkClient.shared.get(url: url)
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
