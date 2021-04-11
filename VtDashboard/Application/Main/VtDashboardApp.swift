import SwiftUI

@main
struct VtDashboardApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(UIState.shared)
                .environmentObject(AuthenticationClient.shared)
        }
    }
}
