import SwiftUI

struct MainView: View {
    @EnvironmentObject var uiState: UIState
    @EnvironmentObject private var authenticationClient: AuthenticationClient
    @State private var currentViewType: ViewType?
    private let viewModel = MainViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(ViewType.allCases) { viewType in
                    NavigationLink(
                        destination: contentView.navigationTitle(viewType.rawValue),
                        tag: viewType,
                        selection: $currentViewType,
                        label: {
                            ImageLabel(iconImageName: viewType.iconImageName, label: viewType.rawValue)
                        })
                }
            }
            .navigationTitle("Menu")
            .listStyle(GroupedListStyle())

            Text("Select a menu!")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .alert(item: $uiState.currentAlert) { $0 }
        .actionSheet(item: $uiState.currentActionSheet) { $0 }
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
            .environmentObject(AuthenticationClient.shared)
    }
}
