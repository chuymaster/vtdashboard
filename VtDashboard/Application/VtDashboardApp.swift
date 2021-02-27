import SwiftUI

@main
struct VtDashboardApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .frame(minWidth: 640, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
        }
    }
}
