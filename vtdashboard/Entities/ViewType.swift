enum ViewType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case channels = "Channels"
    case channelRequests = "Channel Requests"
}
