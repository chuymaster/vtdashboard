import Combine

final class SettingsViewModel: ObservableObject {

    private let authenticationClient: AuthenticationClient

    @Published private(set) var accessToken: String = "null"
    @Published private(set) var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(authenticationClient: AuthenticationClient) {
        self.authenticationClient = authenticationClient
        
        self.authenticationClient.$accessToken
            .sink { [weak self] accessToken in
                self?.accessToken = accessToken ?? "null"
            }
            .store(in: &cancellables)
        
        self.authenticationClient.$error
            .sink { [weak self] error in
                self?.error = error
            }
            .store(in: &cancellables)
    }

    func signup() {
        authenticationClient.signup(email: "test@test.com", password: "testtest")
    }

    func signin() {
        authenticationClient.signin(email: "test@test.com", password: "testtest")
    }
    
    func signOut() {
        authenticationClient.signOut()
    }
}
