import SwiftUI

struct SettingsView: View {
    @AppStorage(UserDefaultsKey.serverEnvironment.rawValue) private var serverEnvironment: ServerEnvironmentValue = .development
    @EnvironmentObject private var uiState: UIState
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Server Environment")
            
            Picker(
                "Server Environment",
                selection: $serverEnvironment) {
                    ForEach(ServerEnvironmentValue.allCases) { environment in
                        Text(environment.rawValue)
                            .tag(environment)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: serverEnvironment, perform: { _ in
                    viewModel.showApplicationWillTerminateAlert()
                })
            
            Divider()
            authorizationView
            
            Divider()
            
            VStack(alignment: .leading) {
                CaptionText(text: "Current Host")
                Text(Endpoint.baseURL.absoluteString)
                    .font(.caption)
            }
            .padding(.bottom, 4)
            
            VStack(alignment: .leading) {
                CaptionText(text: "Access Token")
                Text(viewModel.accessToken ?? "null")
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
                uiState.currentAlert = Alert(
                    title: Text("Warning"),
                    message: Text("Application will be terminated to switch server environment. Please open again."),
                    dismissButton: .destructive(Text("Close"), action: viewModel.signOutAndTerminate)
                )
            }
        })
    }
    
    private var authorizationView: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            if viewModel.accessToken == nil {
                VStack(alignment: .leading) {
                    CaptionText(text: "Sign in with Google")
                    GoogleSignInButton()
                }
                
                VStack(alignment: .leading) {
                    CaptionText(text: "Sign in with Email and Password")
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
                    Button(action: viewModel.signin, label: {
                        Text("Sign In")
                    })
                    Divider()
                    Button(action: viewModel.signup, label: {
                        Text("Sign Up")
                    })
                }
                .frame(height: 28)
            } else {
                VStack(alignment: .leading) {
                    CaptionText(text: "User ID")
                    Text(viewModel.userId ?? "null")
                }
                
                VStack(alignment: .leading) {
                    CaptionText(text: "Provider ID")
                    Text(viewModel.providerId ?? "null")
                }
                HStack {
                    Button(action: viewModel.signOut, label: {
                        Text("Sign Out")
                    })
                    Spacer()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel(authenticationClient: AuthenticationClient()))
            .environmentObject(UIState.shared)
    }
}
