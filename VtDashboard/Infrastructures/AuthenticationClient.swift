import Combine
import Firebase
import Foundation
import OSLog

protocol AuthenticationClientProtocol {
}

final class AuthenticationClient: AuthenticationClientProtocol, ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var accessToken: String?
    @Published var error: Error?
    @Published private var currentUser = CurrentValueSubject<User?, Never>(nil)
    
    static let shared = AuthenticationClient()
    
    private var cancellables = Set<AnyCancellable>()
    private let auth = Auth.auth()
    
    init() {
        auth.addStateDidChangeListener { [weak self] (auth, user) in
            self?.currentUser.send(user)
        }
        
        currentUser
            .map { $0 != nil }
            .assign(to: &$isLoggedIn)
        
        $isLoggedIn
            .filter { !$0 }
            .sink(receiveValue: { [weak self] _ in
                self?.accessToken = nil
            })
            .store(in: &cancellables)
        
        currentUser
            .compactMap { $0 }
            .sink(receiveValue: { user in
                user.getIDTokenForcingRefresh(true, completion: { [weak self] accessToken, error in
                    self?.accessToken = accessToken
                })
            })
            .store(in: &cancellables)
        
        $error
            .compactMap { $0 }
            .sink { error in
                let description = (error as NSError).localizedDescription
                Logger.auth.error("\(description)")
            }
            .store(in: &cancellables)
        
        $accessToken
            .sink { accessToken in
                print(accessToken)
            }
            .store(in: &cancellables)
    }
    
    func signup(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] _, error in
            self?.error = error
        }
    }
    
    func signin(email: String, password: String) {
        auth.signIn(withEmail: email, password: password, completion: { [weak self] _, error in
            self?.error = error
        })
    }
}
