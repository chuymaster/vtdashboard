import Foundation

enum NetworkClientError: Error {
    case unauthenticated
}

extension NetworkClientError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unauthenticated:
            return "Unauthenticated"
        }
    }
}
