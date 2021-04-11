import Firebase
import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {

    override init() {
        super.init()
        FirebaseApp.configure()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
}
