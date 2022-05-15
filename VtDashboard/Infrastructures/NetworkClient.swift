import Foundation
import Alamofire
import Combine

protocol NetworkClientProtocol {
    func get<T: Codable>(endpoint: GetEndpoint) -> Future<T, Error>
    func post<T: Codable>(endpoint: PostEndpoint, parameters: [String: String]) -> Future<T, Error>
}

struct NetworkClient: NetworkClientProtocol {

    private let jsonDecoder: JSONDecoder

    init() {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonDecoder = jsonDecoder
    }

    /// Get data from the url and automatically create the desired object type
    /// The object type must conform to Codable protocol
    func get<T: Codable>(endpoint: GetEndpoint) -> Future<T, Error> {
        return Future { promise in
            guard let accessToken = AuthenticationClient.shared.accessToken else {
                promise(.failure(NetworkClientError.unauthenticated))
                return
            }
            let headers: HTTPHeaders = [
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "Bearer \(accessToken)"
            ]
            let request = AF.request(endpoint.url, headers: headers)
                .response { response in
                    switch response.result {
                    case .success(let data):
                        guard let data = data else {
                            fatalError("data must not be nil in success case.")
                        }
                        if response.response?.statusCode == 401 {
                            promise(.failure(makeAuthError(data: data)))
                            return
                        }
                        do {
                            let object = try self.jsonDecoder.decode(T.self, from: data)
                            promise(.success(object))
                        } catch let error {
                            promise(.failure(error))
                        }
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            request.resume()
        }
    }

    func post<T: Codable>(endpoint: PostEndpoint, parameters: [String: String]) -> Future<T, Error> {
        return Future { promise in
            guard let accessToken = AuthenticationClient.shared.accessToken else {
                promise(.failure(NetworkClientError.unauthenticated))
                return
            }
            let headers: HTTPHeaders = [
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "Bearer \(accessToken)"
            ]
            let request = AF.request(
                endpoint.url,
                method: .post,
                parameters: parameters,
                headers: headers
            )
            .response { response in
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        fatalError("data must not be nil in success case.")
                    }
                    if response.response?.statusCode == 401 {
                        promise(.failure(makeAuthError(data: data)))
                        return
                    }
                    do {
                        let object = try self.jsonDecoder.decode(T.self, from: data)
                        promise(.success(object))
                    } catch let error {
                        promise(.failure(error))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
            request.resume()
        }
    }
    
    private func makeAuthError(data: Data) -> APIError {
        do {
            let errorObject = try self.jsonDecoder.decode(APIErrorResponse.self, from: data)
            return APIError.authError(message: errorObject.error)
        } catch {
            return APIError.authError(message: "Unknown Error")
        }
    }
}
