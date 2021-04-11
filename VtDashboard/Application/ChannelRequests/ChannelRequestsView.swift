import SwiftUI

struct ChannelRequestsView: View {
    @EnvironmentObject private var uiState: UIState
    @State private var selectedChannelRequest: ChannelRequest?
    @ObservedObject var viewModel: ChannelRequestsViewModel

    var body: some View {
        VStack {
            switch viewModel.viewStatus {
            case .loading:
                LoadingView()
            case .loaded:
                ZStack {
                    channelRequestListView
                    if viewModel.isBusy {
                        LoadingOverlayView()
                    }
                }
            case .error:
                ZStack {
                    Text("Error")
                }
            }
        }
        .onAppear {
            viewModel.getChannelRequests()
        }
        .onReceive(viewModel.postErrorSubject, perform: { error in
            if let _ = error {
                uiState.currentAlert = Alert(
                    title: Text("Failure").bold(),
                    message: Text(error?.localizedDescription ?? "Unknown error"),
                    primaryButton: .default(
                        Text("Retry"),
                        action: viewModel.retryUpdateChannelRequest
                    ), secondaryButton: .cancel(Text("Cancel")))
            }
        })
        .actionSheet(item: $selectedChannelRequest) { selectedChannelRequest in
            var selectedChannelRequest = selectedChannelRequest
            let openLinkButton = ActionSheet.Button.default(Text("Open YouTube")) {
                UIApplication.shared.open(selectedChannelRequest.url, options: [:], completionHandler: nil)
            }
            let buttons: [ActionSheet.Button]
            switch selectedChannelRequest.status {
            case .unconfirmed:
                buttons = [
                    openLinkButton,
                    .default(Text("Accept"), action: {
                        selectedChannelRequest.status = .accepted
                        viewModel.updateChannelRequest(request: selectedChannelRequest)
                    }),
                    .default(Text("Mark Pending"), action: {
                        selectedChannelRequest.status = .pending
                        viewModel.updateChannelRequest(request: selectedChannelRequest)
                    }),
                    .destructive(Text("Reject"), action: {
                        viewModel.updateChannelRequest(request: selectedChannelRequest)
                    }),
                    .cancel()
                ]
            case .accepted:
                buttons = [
                    openLinkButton,
                    .destructive(Text("Reject"), action: {
                        selectedChannelRequest.status = .rejected
                        viewModel.updateChannelRequest(request: selectedChannelRequest)
                    }),
                    .cancel()
                ]
            case .pending:
                buttons = [
                    openLinkButton,
                    .default(Text("Accept"), action: {
                        selectedChannelRequest.status = .accepted
                        viewModel.updateChannelRequest(request: selectedChannelRequest)
                    }),
                    .destructive(Text("Reject"), action: {
                        selectedChannelRequest.status = .rejected
                        viewModel.updateChannelRequest(request: selectedChannelRequest)
                    }),
                    .cancel()
                ]
            case .rejected:
                buttons = [
                    openLinkButton,
                    .destructive(Text("Restore"), action: {
                        selectedChannelRequest.status = .unconfirmed
                        viewModel.updateChannelRequest(request: selectedChannelRequest)
                    }),
                    .cancel()
                ]
            }
            return ActionSheet(title: Text("Select Menu"), message: nil, buttons: buttons)
        }
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
                Button(action: {
                    selectedChannelRequest = viewModel.channelRequests[index]
                }, label: {
                    ChannelRequestRow(channelRequest: $viewModel.channelRequests[index])
                })
            }
            .listStyle(PlainListStyle())
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
