import Firebase
import GoogleSignIn

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    private let userDefaults = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let serverEnvironmentValue: ServerEnvironmentValue
        if let serverEnvironment = userDefaults.value(forKey: UserDefaultsKey.serverEnvironment.rawValue) as? String {
            serverEnvironmentValue = ServerEnvironmentValue(rawValue: serverEnvironment) ?? .development
        } else {
            serverEnvironmentValue = .development
        }
        
        let filePath = Bundle.main.path(forResource: serverEnvironmentValue.googleServiceInfoFileName, ofType: "plist")!
        let options = FirebaseOptions(contentsOfFile: filePath)!
        FirebaseApp.configure(options: options)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any])
    -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
