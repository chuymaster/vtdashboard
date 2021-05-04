import Foundation

enum APIError: Error {
    case authError(message: String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .authError(let message):
            return message
        }
    }
}

struct APIErrorResponse: Codable {
    let error: String
}
