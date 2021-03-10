import SwiftUI

struct ChannelsView: View {
    @EnvironmentObject private var uiState: UIState
    @StateObject var viewModel = ChannelsViewModel()
    @State var filterText: String = ""
    
    var body: some View {
        VStack {
            switch viewModel.viewStatus {
            case .loading:
                LoadingView().eraseToAnyView()
            case .loaded:
                ZStack {
                    channelListView
                    if viewModel.isPosting {
                        LoadingOverlayView()
                    }
                }
                .eraseToAnyView()
            case .error:
                ZStack {
                    Text("Error")
                }
                .eraseToAnyView()
            }
        }
        .onReceive(viewModel.$postError, perform: { error in
            if let _ = error {
                uiState.currentAlert = Alert(
                    title: Text("Failure").bold(),
                    message: Text("Failed to update channel"),
                    primaryButton: .default(
                        Text("Retry"),
                        action: viewModel.retryLastOperation
                    ), secondaryButton: .cancel(Text("Cancel")))
            }
        })
        .onAppear {
            viewModel.getChannels()
        }
    }
    
    private var channelListView: some View {
        VStack(alignment: .leading) {
            HStack {
                FilterBar(text: $viewModel.filterText)
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
                    ChannelRow(channel: $viewModel.channels[index]) {
                        viewModel.updateChannel(channel: viewModel.filteredChannels[index])
                    } deleteAction: {
                        uiState.currentAlert = Alert(
                            title: Text("WARNING!"),
                            message: Text("Are you sure to delete \(channel.title)?"),
                            primaryButton: .destructive(
                                Text("Delete"),
                                action: {
                                    viewModel.deleteChannel(channelId: channel.id)
                                }),
                            secondaryButton: .cancel())
                        
                    }
                }
                .listStyle(PlainListStyle())
            }
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
