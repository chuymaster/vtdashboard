import Foundation

public extension TimeInterval {
    var displayText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: Date(timeIntervalSince1970: self / 1_000))
    }
}
