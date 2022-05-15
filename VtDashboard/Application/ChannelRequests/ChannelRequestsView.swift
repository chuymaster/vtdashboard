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
                channelRequestListView
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .onAppear {
            viewModel.getChannelRequests()
        }
        .onReceive(viewModel.postErrorSubject, perform: { error in
            uiState.currentAlert = Alert(
                title: Text("Failure").bold(),
                message: Text(error.localizedDescription),
                primaryButton: .default(
                    Text("Retry"),
                    action: viewModel.retryLastOperation
                ), secondaryButton: .cancel(Text("Cancel")))
        })
        .onReceive(viewModel.acceptAllChannelRequestsErrorSubject, perform: { error in
            uiState.currentAlert = Alert(
                title: Text("Failure").bold(),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("Close")))
        })
        .onReceive(viewModel.$isBusy, perform: { isBusy in
            uiState.isLoadingBlockingUserInteraction = isBusy
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
            VStack {
                List(viewModel.channelRequests) { channelRequest in
                    let index = viewModel.channelRequests
                        .firstIndex { $0.id == channelRequest.id }!
                    Button(action: {
                        uiState.currentActionSheet = makeActionSheet(channelRequest: viewModel.channelRequests[index])
                    }, label: {
                        ChannelRequestRow(channelRequest: $viewModel.channelRequests[index])
                    })
                }
                .listStyle(.plain)
            }
        }
    }

    // swiftlint:disable function_body_length
    private func makeActionSheet(channelRequest: ChannelRequest) -> ActionSheet {
        var channelRequest = channelRequest
        let openLinkButton = ActionSheet.Button.default(Text("Open YouTube")) {
            UIApplication.shared.open(channelRequest.url, options: [:], completionHandler: nil)
        }
        let deleteButton = ActionSheet.Button
            .destructive(Text("Delete"), action: {
                uiState.currentAlert = Alert(
                    title: Text("WARNING!"),
                    message: Text("Are you sure to delete \(channelRequest.title)?"),
                    primaryButton: .destructive(
                        Text("Delete"),
                        action: {
                            viewModel.deleteChannelRequest(channelId: channelRequest.id)
                        }),
                    secondaryButton: .cancel())
            })
        let buttons: [ActionSheet.Button]
        switch channelRequest.status {
        case .unconfirmed:
            buttons = [
                openLinkButton,
                .default(Text("Accept"), action: {
                    channelRequest.status = .accepted
                    viewModel.updateChannelRequest(request: channelRequest)
                }),
                .default(Text("Mark Pending"), action: {
                    channelRequest.status = .pending
                    viewModel.updateChannelRequest(request: channelRequest)
                }),
                .destructive(Text("Reject"), action: {
                    channelRequest.status = .rejected
                    viewModel.updateChannelRequest(request: channelRequest)
                }),
                deleteButton,
                .cancel()
            ]
        case .accepted:
            buttons = [
                openLinkButton,
                deleteButton,
                .cancel()
            ]
        case .pending:
            buttons = [
                openLinkButton,
                .default(Text("Accept"), action: {
                    channelRequest.status = .accepted
                    viewModel.updateChannelRequest(request: channelRequest)
                }),
                .destructive(Text("Reject"), action: {
                    channelRequest.status = .rejected
                    viewModel.updateChannelRequest(request: channelRequest)
                }),
                deleteButton,
                .cancel()
            ]
        case .rejected:
            buttons = [
                openLinkButton,
                .destructive(Text("Restore"), action: {
                    channelRequest.status = .unconfirmed
                    viewModel.updateChannelRequest(request: channelRequest)
                }),
                deleteButton,
                .cancel()
            ]
        }
        return ActionSheet(title: Text("Select Menu"), message: nil, buttons: buttons)
    }
}

struct ChannelRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelRequestsView(
            viewModel: ChannelRequestsViewModel(networkClient: MockNetworkClient())
        )
        .environmentObject(UIState.shared)
    }
}
