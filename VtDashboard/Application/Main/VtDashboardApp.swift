import SwiftUI

@main
struct VtDashboardApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(UIState.shared)
                .frame(minWidth: 800, idealWidth: 1280, maxWidth: .infinity, minHeight: 400, idealHeight: 720, maxHeight: .infinity)
        }
    }
}