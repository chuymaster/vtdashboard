import Combine
import SwiftUI

class UIState: ObservableObject {
    enum Sheet: Int, Identifiable {
        case nothing

        var id: Int { rawValue }
    }
    
    static let shared = UIState()
    @Published var currentSheet: Sheet?
    @Published var currentAlert: Alert?
    @Published var currentActionSheet: ActionSheet?
    @Published var isLoadingBlockingUserInteraction = false

    private init() { }
}
