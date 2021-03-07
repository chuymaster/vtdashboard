import SwiftUI

struct ChannelsView: View {
    @StateObject var viewModel = ChannelsViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.viewStatus {
            case .loading:
                LoadingView().eraseToAnyView()
            case .loaded:
                
                VStack(alignment: .leading) {
                    // header + search box
                    Text("Channels")
                        .bold()
                        .font(.title)
                    
                    List {
                        ForEach(viewModel.channels) { channel in
                            ChannelRow(
                                type: channel.type,
                                imageURL: channel.thumbnailImageUrl,
                                title: channel.title
                            )
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                .frame(minWidth: 300)
                .padding()
                .eraseToAnyView()
            case .error(let error):
                Text(error.localizedDescription)
                    .eraseToAnyView()
            }
            
            // footer pagination
        }
        .onAppear {
            viewModel.getChannels()
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