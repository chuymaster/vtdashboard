import Combine
import SwiftUI

final class AddChannelRequestViewModel: ViewStatusManageable, ObservableObject {
    @Published var viewStatus: ViewStatus = .loaded
    @Published var channelRequest: ChannelRequest?
    @Published var isPostCompleted: String?

    private let networkClient: NetworkClientProtocol

    private var cancellables = Set<AnyCancellable>()

    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }

    func postChannelRequest(id: String, type: ChannelType) {
        viewStatus = .loading
        cancellables.forEach { $0.cancel() }
        networkClient.post(endpoint: .postChannelRequest, parameters: [
            "channel_id": id,
            "type": "\(type.rawValue)"
        ])
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.viewStatus = .loaded
            case .failure(let error):
                self?.viewStatus = .error(error: error)
            }
        } receiveValue: { [weak self] response in
            self?.channelRequest = response
        }
        .store(in: &cancellables)

    }
}
