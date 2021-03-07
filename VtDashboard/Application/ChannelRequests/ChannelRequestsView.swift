import SwiftUI

struct ChannelRequestsView: View {
    @EnvironmentObject private var uiState: UIState
    @StateObject var viewModel = ChannelRequestsViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.viewStatus {
            case .loading:
                LoadingView().eraseToAnyView()
            case .loaded:
                ZStack {
                    channelRequestListView
                    if viewModel.isPosting {
                        LoadingOverlayView()
                    }
                }
            case .error:
                Text("Error")
            }
        }
        .onReceive(viewModel.$postError, perform: { error in
            if let _ = error {
                uiState.currentAlert = Alert(
                    title: Text("Failure").bold(),
                    message: Text("Failed to add new channel"),
                    primaryButton: .default(
                        Text("Retry"),
                        action: viewModel.retryPostChannel
                    ), secondaryButton: .cancel(Text("Cancel")))
            }
        })
        .onAppear {
            viewModel.getChannelRequests()
        }
    }
    
    private var channelRequestListView: some View {
        List {
            ForEach(viewModel.channelRequests) { channelRequest in
                let index = viewModel.channelRequests
                    .firstIndex { $0.id == channelRequest.id }!
                HStack {
                    ChannelRequestRow(
                        channelRequest: $viewModel.channelRequests[index],
                        changeAction: {
                            viewModel.postChannel(request: viewModel.channelRequests[index])
                        }
                    )
                    Spacer()
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct ChannelRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelRequestsView(
            viewModel: ChannelRequestsViewModel(networkClient: MockNetworkClient())
        )
    }
}
