import SwiftUI

struct MainView: View {
    
    @State var currentViewType: ViewType = .channelRequests
    
    var body: some View {
        HStack {
            SidebarView(viewType: $currentViewType)
                .frame(width: 220)
            contentView
        }
        
    }
    
    private var contentView: some View {
        switch currentViewType {
        case .channels:
            return ChannelsView(
                viewModel: ChannelsViewModel(
                    networkClient: MockNetworkClient()
                )
            )
            .eraseToAnyView()
        case .channelRequests:
            return ChannelRequestsView(
                viewModel: ChannelRequestsViewModel(
                    networkClient: MockNetworkClient()
                )
            )
            .eraseToAnyView()
        case .addChannel:
            return AddChannelRequestView(
            )
            .eraseToAnyView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewLayout(.sizeThatFits)
    }
}
