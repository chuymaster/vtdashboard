import SwiftUI

struct ChannelRequestsView: View {
    @EnvironmentObject private var uiState: UIState
    @ObservedObject var viewModel: ChannelRequestsViewModel

    var body: some View {
        VStack {
            switch viewModel.viewStatus {
            case .loading:
                LoadingView()
            case .loaded:
                ZStack {
                    reloadKeyboardShortcut
                    channelRequestListView
                    if viewModel.isPosting || viewModel.isReloading {
                        LoadingOverlayView()
                    }
                }
            case .error:
                ZStack {
                    reloadKeyboardShortcut
                    Text("Error")
                }
            }
        }
        .onAppear {
            viewModel.getChannelRequests()
        }
        .onReceive(viewModel.$postError, perform: { error in
            if let _ = error {
                uiState.currentAlert = Alert(
                    title: Text("Failure").bold(),
                    message: Text("Failed to add new channel"),
                    primaryButton: .default(
                        Text("Retry"),
                        action: viewModel.retryUpdateChannelRequest
                    ), secondaryButton: .cancel(Text("Cancel")))
            }
        })
    }

    @ViewBuilder
    private var channelRequestListView: some View {
        if viewModel.channelRequests.isEmpty {
            ZStack {
                HStack {
                    Spacer()
                    Text("No Request")
                    Spacer()
                }
            }
        } else {
            List(viewModel.channelRequests) { channelRequest in
                let index = viewModel.channelRequests
                    .firstIndex { $0.id == channelRequest.id }!
                ChannelRequestRow(
                    channelRequest: $viewModel.channelRequests[index],
                    changeAction: {
                        viewModel.updateChannelRequest(request: viewModel.channelRequests[index])
                    }
                )
            }
            .listStyle(PlainListStyle())
        }

    }

    private var reloadKeyboardShortcut: some View {
        // TODO:- Create a real button and toolstip for shortcut
        Button(action: {
            viewModel.getChannelRequests()
        }, label: {
            EmptyView()
        })
        .keyboardShortcut("r")
        .opacity(0) // workaround to enable .keyboardShortcut while hiding button
    }
}

struct ChannelRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelRequestsView(
            viewModel: ChannelRequestsViewModel(networkClient: MockNetworkClient())
        )
    }
}
