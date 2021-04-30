import SwiftUI

@main
struct VtDashboardApp: App {
    // swiftlint:disable weak_delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(UIState.shared)
                .environmentObject(AuthenticationClient.shared)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    AuthenticationClient.shared.refreshToken()
                }
        }
    }
}
