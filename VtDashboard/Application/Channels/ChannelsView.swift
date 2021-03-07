import SwiftUI

struct ChannelsView: View {
    @EnvironmentObject private var uiState: UIState
    @StateObject var viewModel = ChannelsViewModel()
    
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
            Text("Channels")
                .bold()
                .font(.title)
            
            List {
                ForEach(viewModel.channels) { channel in
                    let index = viewModel.channels.firstIndex { $0.id == channel.id }!
                    ChannelRow(channel: $viewModel.channels[index]) {
                        viewModel.updateChannel(channel: viewModel.channels[index])
                    } deleteAction: {
                        viewModel.deleteChannel(channelId: channel.id)
                    }
                }
            }
            .listStyle(PlainListStyle())
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
