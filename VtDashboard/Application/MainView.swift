import SwiftUI

struct MainView: View {
    @EnvironmentObject var uiState: UIState

    @State var currentViewType: ViewType? = .channelRequests

    var body: some View {
        HStack {
            SidebarView(viewType: $currentViewType)
                .frame(width: 220)
            contentView
        }
        .alert(item: $uiState.currentAlert) { $0 }
    }

    @ViewBuilder
    private var contentView: some View {
        // TODO:- Store created view in ViewModel to prevent reinitialization
        switch currentViewType {
        case .channels:
            ChannelsView()
        case .channelRequests:
            ChannelRequestsView()
        case .addChannel:
            AddChannelRequestView()
        case .settings:
            SettingsView()
        case .none:
            EmptyView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UIState.shared)
            .previewLayout(.sizeThatFits)
    }
}
