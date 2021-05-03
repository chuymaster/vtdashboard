import Combine
import SwiftUI

class UIState: ObservableObject {
    struct Sheet: Identifiable {
        let id = UUID().uuidString
        let view: AnyView
    }
    static let shared = UIState()
    @Published var currentSheet: Sheet?
    @Published var currentAlert: Alert?
    @Published var currentActionSheet: ActionSheet?
    @Published var isLoadingBlockingUserInteraction = false

    private init() { }
}
