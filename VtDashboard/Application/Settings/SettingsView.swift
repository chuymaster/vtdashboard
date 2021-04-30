import SwiftUI

struct SettingsView: View {
    @AppStorage(UserDefaultsKey.serverEnvironment.rawValue) private var serverEnvironment: ServerEnvironmentValue = .development
    @EnvironmentObject private var uiState: UIState
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Server Environment")
            
            Picker("Server Environment",
                   selection: $serverEnvironment) {
                ForEach(ServerEnvironmentValue.allCases) { environment in
                    Text(environment.rawValue)
                        .tag(environment)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: serverEnvironment, perform: { _ in
                viewModel.showApplicationWillTerminateAlert()
            })
            
            Divider()
            
            VStack {
                TextField(
                    "Email",
                    text: $viewModel.email
                )
                .keyboardType(.emailAddress)
                .padding(8)
                .modifier(RoundedBorder())
                SecureField(
                    "Password",
                    text: $viewModel.password,
                    onCommit: viewModel.signin
                )
                .padding(8)
                .modifier(RoundedBorder())
            }
            
            HStack {
                Button(action: viewModel.signup, label: {
                    Text("Sign Up")
                })
                Spacer()
                Button(action: viewModel.signin, label: {
                    Text("Sign In")
                })
                Spacer()
                Button(action: viewModel.signOut, label: {
                    Text("Sign Out")
                })
            }
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Current host")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Text(Endpoint.baseURL.absoluteString)
                    .font(.caption)
            }
            .padding(.bottom, 4)
            
            VStack(alignment: .leading) {
                Text("Access Token")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Text(viewModel.accessToken)
                    .font(.caption)
            }
            
            Spacer()
        }
        .padding()
        .onReceive(viewModel.$error, perform: { error in
            if let error = error {
                let alert = Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .cancel())
                uiState.currentAlert = alert
            }
        })
        .onReceive(viewModel.$isBusy, perform: { isBusy in
            uiState.isLoadingBlockingUserInteraction = isBusy
        })
        .onReceive(viewModel.$shouldAlertApplicationWillTerminate, perform: { shouldAlertApplicationWillExit in
            if shouldAlertApplicationWillExit {
                uiState.currentAlert = Alert(title: Text("Warning"), message: Text("Application will be terminated to switch server environment. Please open again."), dismissButton: .destructive(Text("Close"), action: viewModel.signOutAndTerminate))
            }
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel(authenticationClient: AuthenticationClient()))
            .environmentObject(UIState.shared)
    }
}
