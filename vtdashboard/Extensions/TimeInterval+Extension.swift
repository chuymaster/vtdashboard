import Foundation

extension TimeInterval {
    var displayTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
