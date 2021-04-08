import Foundation

final class LoginViewModel: ObservableObject {
    
    private let authenticationClient: AuthenticationClient
    
    init(authenticationClient: AuthenticationClient) {
        self.authenticationClient = authenticationClient
    }
    
    func signup() {
        authenticationClient.signup(email: "test@test.com", password: "testtest")
    }
    
    func signin() {
        authenticationClient.signin(email: "test@test.com", password: "testtest")
    }
}
