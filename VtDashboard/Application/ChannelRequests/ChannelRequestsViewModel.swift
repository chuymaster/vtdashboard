import Combine
import SwiftUI
import OSLog

final class ChannelRequestsViewModel: ViewStatusManageable, ObservableObject {

    @Published var viewStatus: ViewStatus = .loading
    @Published var channelRequests: [ChannelRequest] = []

    @Published private(set) var isBusy = false
    @Published private var isPosting = false
    @Published private var isReloading = false

    let postErrorSubject = PassthroughSubject<Error, Never>()

    private let networkClient: NetworkClientProtocol
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
            .sink(receiveValue: { [weak self] _ in
                self?.isPosting = false
            })
            .store(in: &cancellables)

        $isPosting
            .combineLatest($isReloading)
            .map { $0 || $1 }
            .assign(to: &$isBusy)
    }

    func getChannelRequests() {
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
                    withAnimation(.easeInOut(duration: 1.5)) {
                        self?.viewStatus = .loaded
                    }
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
            Logger().error("No request to retry")
            return
        }
        updateChannelRequest(request: request)
    }
}
