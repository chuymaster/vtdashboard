import SwiftUI

struct MainView: View {
    @EnvironmentObject var uiState: UIState
    @EnvironmentObject private var authenticationClient: AuthenticationClient
    @State private var currentViewType: ViewType? = .login
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
        case .channelRequests:
            ChannelRequestsView(viewModel: viewModel.channelRequestsViewModel)
        case .channels:
            ChannelsView(viewModel: viewModel.channelsViewModel)
        case .addChannel:
            AddChannelRequestView()
        case .settings:
            SettingsView()
        case .login:
            LoginView(viewModel: LoginViewModel(authenticationClient: authenticationClient))
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
