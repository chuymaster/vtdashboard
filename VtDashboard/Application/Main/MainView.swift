import SwiftUI

struct MainView: View {
    @EnvironmentObject var uiState: UIState
    @State private var currentViewType: ViewType? = .channelRequests
    private let viewModel = MainViewModel()

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
        switch currentViewType {
        case .channels:
            ChannelsView(viewModel: viewModel.channelsViewModel)
        case .channelRequests:
            ChannelRequestsView(viewModel: viewModel.channelRequestsViewModel)
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
