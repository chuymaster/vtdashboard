import Combine
import Firebase
import Foundation
import OSLog

protocol AuthenticationClientProtocol {
}

final class AuthenticationClient: AuthenticationClientProtocol, ObservableObject {

    @Published var isLoggedIn = false
    @Published var isLoading = false
    @Published var accessToken: String?
    @Published var userId: String?
    @Published var error: Error?
    @Published private var currentUser = CurrentValueSubject<User?, Never>(nil)

    static let shared = AuthenticationClient()

    private var cancellables = Set<AnyCancellable>()
    private let auth = Auth.auth()

    init() {
        auth.addStateDidChangeListener { [weak self] (_, user) in
            self?.currentUser.send(user)
        }

        currentUser
            .map { $0 != nil }
            .assign(to: &$isLoggedIn)
        
        currentUser
            .compactMap { $0?.uid }
            .assign(to: &$userId)

        $isLoggedIn
            .filter { !$0 }
            .sink(receiveValue: { [weak self] _ in
                self?.accessToken = nil
            })
            .store(in: &cancellables)

        currentUser
            .compactMap { $0 }
            .sink(receiveValue: { user in
                user.getIDTokenForcingRefresh(true, completion: { [weak self] accessToken, _ in
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
            .sink(receiveValue: { [weak self]_ in
                self?.objectWillChange.send()
            })
            .store(in: &cancellables)
    }

    func signup(email: String, password: String) {
        isLoading = true
        auth.createUser(withEmail: email, password: password) { [weak self] _, error in
            self?.error = error
            self?.isLoading = false
        }
    }

    func signin(email: String, password: String) {
        isLoading = true
        auth.signIn(withEmail: email, password: password, completion: { [weak self] _, error in
            self?.error = error
            self?.isLoading = false
        })
    }

    func signOut() {
        try? auth.signOut()
    }
}
