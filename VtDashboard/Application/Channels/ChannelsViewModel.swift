import Combine
import SwiftUI
import OSLog

final class ChannelsViewModel: ViewStatusManageable, ObservableObject {
    
    private enum Operation {
        case updateChannel(channel: Channel)
        case deleteChannel(channelId: String)
    }
    
    @Published var viewStatus: ViewStatus = .loading
    @Published var channels: [Channel] = []
    
    @Published private(set) var isPosting: Bool = false
    @Published private(set) var postError: Error?
    @Published private(set) var postedChannel: Channel?
    
    private let networkClient: NetworkClientProtocol
    
    private var lastOperation: Operation?
    private var postErrorSubject = CurrentValueSubject<Error?, Never>(nil)
    private var postCompletedSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
        
        postCompletedSubject
            .sink(receiveValue: { [weak self] _ in
                self?.isPosting = false
                self?.getChannels()
            })
            .store(in: &cancellables)
        
        postErrorSubject
            .sink(receiveValue: { [weak self] error in
                self?.isPosting = false
                self?.postError = error
            })
            .store(in: &cancellables)
    }
    
    func getChannels() {
        if channels.isEmpty {
            viewStatus = .loading
        }
        networkClient.get(endpoint: .getChannelList)
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
            .store(in: &cancellables)
    }
    
    func updateChannel(channel: Channel) {
        isPosting = true
        lastOperation = .updateChannel(channel: channel)
        
        let postChannel: Future<Channel, Error> = networkClient.post(endpoint: .postChannel, parameters: [
            "channel_id": channel.channelId,
            "title": channel.title,
            "thumbnail_image_url": channel.thumbnailImageUrl,
            "type": "\(channel.type.rawValue)"
        ])
        
        postChannel
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.postCompletedSubject.send()
            case .failure(let error):
                self?.postErrorSubject.send(error)
            }
        } receiveValue: { _ in }
        .store(in: &cancellables)
    }
    
    func deleteChannel(channelId: String) {
        isPosting = true
        lastOperation = .deleteChannel(channelId: channelId)
        
        let deleteChannel: Future<String?, Error> = networkClient.post(endpoint: .deleteChannel, parameters: [
            "channel_id": channelId,
        ])
        
        deleteChannel
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.postCompletedSubject.send()
            case .failure(let error):
                // FIxME:- Temporary fix until server returns json-encoding response
                if error is DecodingError {
                    self?.postCompletedSubject.send()
                } else {
                    self?.postErrorSubject.send(error)
                }
            }
        } receiveValue: { _ in }
        .store(in: &cancellables)
    }
    
    func retryLastOperation() {
        switch lastOperation {
        case .updateChannel(let channel):
            updateChannel(channel: channel)
        case .deleteChannel(let channelId):
            deleteChannel(channelId: channelId)
        case .none:
            return
        }
    }
}
