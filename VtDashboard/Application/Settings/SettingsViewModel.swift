import Combine
import Darwin

final class SettingsViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    
    @Published private(set) var isBusy = false
    @Published private(set) var accessToken = "null"
    @Published private(set) var error: Error?
    @Published private(set) var shouldAlertApplicationWillTerminate = false
    
    private let authenticationClient: AuthenticationClient
    private var cancellables = Set<AnyCancellable>()

    init(authenticationClient: AuthenticationClient) {
        self.authenticationClient = authenticationClient

        self.authenticationClient.$accessToken
            .sink { [weak self] accessToken in
                self?.accessToken = accessToken ?? "null"
            }
            .store(in: &cancellables)
        
        self.authenticationClient.$isLoading
            .assign(to: &$isBusy)

        self.authenticationClient.$error
            .sink { [weak self] error in
                self?.error = error
            }
            .store(in: &cancellables)
    }
    
    func signup() {
        authenticationClient.signup(email: email, password: password)
    }

    func signin() {
        authenticationClient.signin(email: email, password: password)
    }

    func signOut() {
        authenticationClient.signOut()
    }
    
    func showApplicationWillTerminateAlert() {
        shouldAlertApplicationWillTerminate = true
    }
    
    func signOutAndTerminate() {
        signOut()
        exit(0)
    }
}
