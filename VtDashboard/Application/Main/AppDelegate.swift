import Firebase
import Foundation
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var menuBarItem: NSStatusItem!
    private lazy var popover: NSPopover = {
        let mainView = MainView()
            .environmentObject(UIState.shared)
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 800, height: 600)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: mainView)
        return popover
    }()
    
    override init() {
        super.init()
        FirebaseApp.configure()
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        menuBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        if let button = menuBarItem.button {
            button.image = NSImage(named: "MenuBarIcon")
            button.action = #selector(togglePopover(_:))
        }
    }
    
    // Create the status item
    @objc private func togglePopover(_ sender: AnyObject?) {
        if let button = menuBarItem.button {
            if self.popover.isShown {
                self.popover.performClose(sender)
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
