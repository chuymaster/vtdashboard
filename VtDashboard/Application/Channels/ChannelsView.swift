import SwiftUI

struct ChannelsView: View {
    @EnvironmentObject private var uiState: UIState
    @ObservedObject var viewModel: ChannelsViewModel
    @State var filterText: String = ""
    
    var body: some View {
        VStack {
            switch viewModel.viewStatus {
            case .loading:
                LoadingView()
            case .loaded:
                channelListView
            case .error:
                ZStack {
                    Text("Error")
                }
            }
        }
        .onAppear {
            viewModel.getChannels()
        }
        .onReceive(viewModel.postErrorSubject, perform: { error in
            if let _ = error {
                uiState.currentAlert = Alert(
                    title: Text("Failure").bold(),
                    message: Text(error?.localizedDescription ?? "Unknown error"),
                    primaryButton: .default(
                        Text("Retry"),
                        action: viewModel.retryLastOperation
                    ), secondaryButton: .cancel(Text("Cancel")))
            }
        })
        .onReceive(viewModel.$isBusy, perform: { isBusy in
            uiState.isLoadingBlockingUserInteraction = isBusy
        })
    }
    
    private var channelListView: some View {
        VStack(alignment: .leading) {
            HStack {
                SearchBar(text: $viewModel.filterText)
                Spacer()
                Text("Total channels: \(viewModel.channels.count)")
                    .font(.callout)
                    .padding()
            }
            Divider()
            
            if viewModel.filteredChannels.isEmpty {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("No Channel")
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                List(viewModel.filteredChannels) { channel in
                    let index = viewModel.channels.firstIndex { $0.id == channel.id }!
                    Button(action: {
                        uiState.currentActionSheet = makeActionSheet(channel: viewModel.channels[index])
                    }, label: {
                        ChannelRow(channel: $viewModel.channels[index])
                    })
                }
                .listStyle(PlainListStyle())
            }
        }
        .toolbar{
            Button(action: {
                let buttons: [ActionSheet.Button] = [
                    .default(Text("Sort by Updated at")) {
                        viewModel.sortType = .updatedAt
                    },
                    .default(Text("Sort by Subscribers"), action: {
                        viewModel.sortType = .subscribers
                    }),
                    .default(Text("Sort by Views"), action: {
                        viewModel.sortType = .views
                    }),
                    .cancel()
                ]
                uiState.currentActionSheet = ActionSheet(
                    title: Text("Select Sort Filter"),
                    message: nil,
                    buttons: buttons
                )
            }, label: {
                Image(systemName: "line.horizontal.3.decrease.circle")
            })
        }
    }
    
    private func makeActionSheet(channel: Channel) -> ActionSheet {
        let buttons: [ActionSheet.Button] = [
            .default(Text("Open YouTube")) {
                UIApplication.shared.open(channel.url, options: [:], completionHandler: nil)
            },
            .default(Text("Update"), action: {
                viewModel.updateChannel(channel: channel)
            }),
            .destructive(Text("Delete"), action: {
                uiState.currentAlert = Alert(
                    title: Text("WARNING!"),
                    message: Text("Are you sure to delete \(channel.title)?"),
                    primaryButton: .destructive(
                        Text("Delete"),
                        action: {
                            viewModel.deleteChannel(channelId: channel.id)
                        }),
                    secondaryButton: .cancel())
            }),
            .cancel()
        ]
        return ActionSheet(title: Text("Select Menu"), message: nil, buttons: buttons)
    }
}

struct ChannelsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsView(
            viewModel: ChannelsViewModel(
                networkClient: MockNetworkClient()
            )
        )
    }
}
