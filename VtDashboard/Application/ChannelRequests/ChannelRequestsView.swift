import SwiftUI

struct ChannelRequestsView: View {
    @StateObject var viewModel = ChannelRequestsViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.viewStatus {
            case .loading:
                LoadingView().eraseToAnyView()
            case .loaded:
                List {
                    ForEach(viewModel.channelRequests) { channelRequest in
                        let index = viewModel.channelRequests.firstIndex { $0.id == channelRequest.id
                        }!
                        HStack {
                            ChannelRequestRow(
                                channelRequest: $viewModel.channelRequests[index],
                                changeAction: {
                                    let channelRequest = viewModel.channelRequests[index]
                                    viewModel.postChannel(
                                        id: channelRequest.id,
                                        title: channelRequest.title,
                                        thumbnailImageUrl: channelRequest.thumbnailImageUrl,
                                        type: channelRequest.type
                                    )
                                }
                            )
                            Spacer()
                        }
                    }
                }
                .listStyle(PlainListStyle())
            case .error:
                Text("Error")
            }
        }
        .onAppear {
            viewModel.getChannelRequests()
        }
    }
}

struct ChannelRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelRequestsView(
            viewModel: ChannelRequestsViewModel(networkClient: MockNetworkClient())
        )
    }
}
