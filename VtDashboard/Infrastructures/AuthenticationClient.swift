import Combine
import Firebase
import FirebaseAuth
import Foundation
import GoogleSignIn
import OSLog

protocol AuthenticationClientProtocol {
}

final class AuthenticationClient: NSObject, AuthenticationClientProtocol, ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var isLoading = false
    @Published var accessToken: String?
    @Published var userId: String?
    @Published var providerId: String?
    @Published var error: Error?
    @Published private var currentUser: User?
    
    static let shared = AuthenticationClient()
    
    private var cancellables = Set<AnyCancellable>()
    private lazy var signInConfig = GIDConfiguration(clientID: FirebaseApp.app()?.options.clientID ?? "")
    private let auth = Auth.auth()
    
    override init() {
        super.init()
        
        auth.addStateDidChangeListener { [weak self] (_, user) in
            self?.currentUser = user
        }
        
        $currentUser
            .map { $0 != nil }
            .assign(to: &$isLoggedIn)
        
        $currentUser
            .map { $0?.providerData.first?.providerID }
            .assign(to: &$providerId)
        
        $currentUser
            .compactMap { $0?.uid }
            .assign(to: &$userId)
        
        $isLoggedIn
            .filter { !$0 }
            .sink(receiveValue: { [weak self] _ in
                self?.accessToken = nil
            })
            .store(in: &cancellables)
        
        $currentUser
            .compactMap { $0 }
            .sink(receiveValue: { user in
                user.getIDToken(completion: { [weak self] accessToken, error in
                    self?.accessToken = accessToken
                    self?.error = error
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
            .sink(receiveValue: { [weak self] _ in
                self?.objectWillChange.send()
            })
            .store(in: &cancellables)
    }
    
    func signUp(email: String, password: String) {
        isLoading = true
        auth.createUser(withEmail: email, password: password) { [weak self] _, error in
            self?.error = error
            self?.isLoading = false
        }
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        auth.signIn(withEmail: email, password: password, completion: { [weak self] _, error in
            self?.error = error
            self?.isLoading = false
        })
    }
    
    func signInWithGoogle() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        
        GIDSignIn.sharedInstance.signIn(
            with: signInConfig,
            presenting: presentingViewController,
            callback: { user, error in
                if let error = error {
                    if (error as NSError).code == GIDSignInError.Code.hasNoAuthInKeychain.rawValue {
                        Logger.auth.error("The user has not signed in before or they have since signed out.")
                    } else {
                        Logger.auth.error("\(error.localizedDescription)")
                    }
                    return
                }

                guard let authentication = user?.authentication else { return }
                let credential = GoogleAuthProvider.credential(
                    withIDToken: authentication.idToken ?? "",
                    accessToken: authentication.accessToken)

                self.isLoading = true
                Auth.auth().signIn(with: credential) { [weak self] _, error in
                    self?.error = error
                    self?.isLoading = false
                }
            })
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        try? auth.signOut()
        accessToken = nil
    }
    
    func refreshToken() {
        currentUser?.getIDToken(completion: { [weak self] accessToken, error in
            self?.accessToken = accessToken
            self?.error = error
        })
    }
}
