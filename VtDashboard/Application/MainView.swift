import SwiftUI

struct MainView: View {
    
    @State var currentViewType: ViewType? = .channelRequests
    
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
            return ChannelsView()
            .eraseToAnyView()
        case .channelRequests:
            return ChannelRequestsView()
            .eraseToAnyView()
        case .addChannel:
            return AddChannelRequestView()
            .eraseToAnyView()
        case .none:
            return EmptyView()
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
