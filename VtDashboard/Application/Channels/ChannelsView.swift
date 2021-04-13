import SwiftUI

struct ChannelsView: View {
    @EnvironmentObject private var uiState: UIState
    @ObservedObject var viewModel: ChannelsViewModel
    @State var filterText: String = ""
    
    @State private var selectedChannel: Channel?
    
    var body: some View {
        VStack {
            switch viewModel.viewStatus {
            case .loading:
                LoadingView()
            case .loaded:
                ZStack {
                    channelListView
                    if viewModel.isPosting || viewModel.isReloading {
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
                        selectedChannel = viewModel.channels[index]
                    }, label: {
                        ChannelRow(channel: $viewModel.channels[index])
                    })
                }
                .listStyle(PlainListStyle())
            }
        }
        .actionSheet(item: $selectedChannel) { selectedChannel in
            let buttons: [ActionSheet.Button] = [
                .default(Text("Open YouTube")) {
                    UIApplication.shared.open(selectedChannel.url, options: [:], completionHandler: nil)
                },
                .default(Text("Update"), action: {
                    viewModel.updateChannel(channel: selectedChannel)
                }),
                .destructive(Text("Delete"), action: {
                    uiState.currentAlert = Alert(
                        title: Text("WARNING!"),
                        message: Text("Are you sure to delete \(selectedChannel.title)?"),
                        primaryButton: .destructive(
                            Text("Delete"),
                            action: {
                                viewModel.deleteChannel(channelId: selectedChannel.id)
                            }),
                        secondaryButton: .cancel())
                }),
                .cancel()
            ]
            return ActionSheet(title: Text("Select Menu"), message: nil, buttons: buttons)
        }
        .contextMenu {
            Button {
                viewModel.sortType = .updatedAt
            } label: {
                ImageLabel(iconImageName: "clock", label: "Sort by Updated")
            }
            Button {
                viewModel.sortType = .subscribers
            } label: {
                ImageLabel(iconImageName: "person.3", label: "Sort by Subscribers")
            }
            Button {
                viewModel.sortType = .views
            } label: {
                ImageLabel(iconImageName: "eyes", label: "Sort by Views")
            }
        }
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
