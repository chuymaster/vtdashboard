import Combine
import SwiftUI
import OSLog

final class ChannelRequestsViewModel: ViewStatusManageable, ObservableObject {
    
    @Published var viewStatus: ViewStatus = .loading
    @Published var channelRequests: [ChannelRequest] = []
    
    @Published private(set) var isPosting: Bool = false
    @Published private(set) var isReloading: Bool = false
    @Published private(set) var postError: Error?
    @Published private(set) var postedChannel: Channel?
    
    private let networkClient: NetworkClientProtocol
    
    private var postErrorSubject = CurrentValueSubject<Error?, Never>(nil)
    private var postCompletedSubject = PassthroughSubject<Void, Never>()
    private var lastUpdateChannelRequest: ChannelRequest?
    private var cancellables = Set<AnyCancellable>()
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
        
        postCompletedSubject
            .sink(receiveValue: { [weak self] _ in
                self?.isPosting = false
                self?.getChannelRequests()
            })
            .store(in: &cancellables)
        
        postErrorSubject
            .sink(receiveValue: { [weak self] error in
                self?.isPosting = false
                self?.postError = error
            })
            .store(in: &cancellables)
    }
    
    func getChannelRequests() {
        cancellables.forEach { $0.cancel() }
        if viewStatus != .loading {
            isReloading = true
        }
        let getChannelRequestList: Future<[ChannelRequest], Error> =
            networkClient.get(endpoint: .getChannelRequestList)
        
            getChannelRequestList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isReloading = false
                switch completion {
                case .finished:
                    self?.viewStatus = .loaded
                case .failure(let error):
                    self?.viewStatus = .error(error: error)
                }
            } receiveValue: { [weak self] channelRequests in
                self?.channelRequests = channelRequests
                    .sorted(by: { ch1, ch2 -> Bool in
                        ch1.updatedAt > ch2.updatedAt
                    })
            }
            .store(in: &cancellables)
    }
    
    func updateChannelRequest(request: ChannelRequest) {
        cancellables.forEach { $0.cancel() }
        isPosting = true
        lastUpdateChannelRequest = request
        
        let postChannelRequest: Future<ChannelRequest, Error> =
            networkClient.post(endpoint: .postChannelRequest, parameters: [
                "channel_id": request.channelId,
                "type": "\(request.type.rawValue)",
                "status": "\(request.status.rawValue)"
            ])
        
        if request.status == .accepted {
            // Add new Channel and update ChannelRequest
            let postChannel: Future<Channel, Error> =
                networkClient.post(endpoint: .postChannel, parameters: [
                    "channel_id": request.channelId,
                    "title": request.title,
                    "thumbnail_image_url": request.thumbnailImageUrl,
                    "type": "\(request.type.rawValue)"
                ])
            
            postChannelRequest
                .combineLatest(postChannel)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.postCompletedSubject.send()
                    case .failure(let error):
                        self?.postErrorSubject.send(error)
                    }
                }, receiveValue: { _ in })
                .store(in: &cancellables)
        } else {
            // Update ChannelRequest only
            postChannelRequest
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.postCompletedSubject.send()
                    case .failure(let error):
                        self?.postErrorSubject.send(error)
                    }
                }, receiveValue: { _ in })
                .store(in: &cancellables)
        }
    }
    
    func retryUpdateChannelRequest() {
        guard let request = lastUpdateChannelRequest else {
            print(Logger().error("No request to retry"))
            return
        }
        updateChannelRequest(request: request)
    }
}
