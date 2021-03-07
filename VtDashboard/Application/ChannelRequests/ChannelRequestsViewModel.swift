import Combine
import SwiftUI

final class ChannelRequestsViewModel: ViewStatusManageable, ObservableObject {
    @Published var viewStatus: ViewStatus = .loading
    @Published var channelRequests: [ChannelRequest] = []
    @Published var isPostCompleted: String?
    @Published var error: Error?
    
    private let networkClient: NetworkClientProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func getChannelRequests() {
        cancellables.forEach { $0.cancel() }
        viewStatus = .loading
        networkClient.get(endpoint: .getChannelRequestList)
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
            .store(in: &cancellables)
            
    }
    
    func postChannel(id: String, title: String, thumbnailImageUrl: String, type: ChannelType) {
        cancellables.forEach { $0.cancel() }
        networkClient.post(endpoint: .postChannel, parameters: [
            "channel_id": id,
            "title": title,
            "thumbnail_image_url": thumbnailImageUrl,
            "type": "\(type.rawValue)"
        ])
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.error = error
            }
        } receiveValue: { [weak self] response in
            self?.isPostCompleted = response
        }
        .store(in: &cancellables)
        
    }
}
