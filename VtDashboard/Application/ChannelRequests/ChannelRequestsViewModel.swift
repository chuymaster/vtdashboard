import Combine
import SwiftUI
import OSLog

final class ChannelRequestsViewModel: ViewStatusManageable, ObservableObject {
    
    @Published var viewStatus: ViewStatus = .loading
    @Published var channelRequests: [ChannelRequest] = []
    
    @Published var isPosting: Bool = false
    @Published var isPostCompleted: Bool = false
    @Published var postError: Error?
    @Published var postedChannel: Channel?
    
    private let networkClient: NetworkClientProtocol
    
    private var lastPostChannelRequest: ChannelRequest?
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
    
    func postChannel(request: ChannelRequest) {
        cancellables.forEach { $0.cancel() }
        isPosting = true
        isPostCompleted = false
        lastPostChannelRequest = request
        
        networkClient.post(endpoint: .postChannel, parameters: [
            "channel_id": request.channelId,
            "title": request.title,
            "thumbnail_image_url": request.thumbnailImageUrl,
            "type": "\(request.type.rawValue)"
        ])
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] completion in
            self?.isPosting = false
            switch completion {
            case .finished:
                self?.isPostCompleted = true
            case .failure(let error):
                self?.postError = error
            }
        }, receiveValue: { [weak self] value in
            self?.postedChannel = value
        })
        .store(in: &cancellables)
    }
    
    func retryPostChannel() {
        guard let request = lastPostChannelRequest else {
            print(Logger().error("No request to retry"))
            return
        }
        postChannel(request: request)
    }
}
