import Firebase
import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    private let userDefaults = UserDefaults.standard

    override init() {
        super.init()
        
        let serverEnvironmentValue: ServerEnvironmentValue
        if let serverEnvironment = userDefaults.value(forKey: UserDefaultsKey.serverEnvironment.rawValue) as? String {
            serverEnvironmentValue = ServerEnvironmentValue(rawValue: serverEnvironment) ?? .development
        } else {
            serverEnvironmentValue = .development
        }
        
        let filePath = Bundle.main.path(forResource: serverEnvironmentValue.googleServiceInfoFileName, ofType: "plist")!
        print(filePath)
        let options = FirebaseOptions(contentsOfFile: filePath)!
        FirebaseApp.configure(options: options)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
}
