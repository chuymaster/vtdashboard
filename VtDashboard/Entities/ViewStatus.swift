enum ViewStatus: Equatable {
    case loading
    case loaded
    case error(error: Error)
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch(lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.error(error: _), .error(error: _)):
            return true
        default:
            return false
        }
        
    }
}
