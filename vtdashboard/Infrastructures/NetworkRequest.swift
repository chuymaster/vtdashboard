import Foundation
import Alamofire
import Combine

struct NetworkRequest {
    private let jsonDecoder: JSONDecoder
    
    init() {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonDecoder = jsonDecoder
    }
    
    /// Get data from the url and automatically create the desired object type
    /// The object type must conform to Codable protocol
    func get<T: Codable>(url: String) -> Future<T, Error> {
        return Future { promise in
            let request = AF.request(url)
                .response { response in
                    switch response.result {
                    case .success(let data):
                        guard let data = data else {
                            fatalError("data must not be nil in success case.")
                        }
                        do {
                            let object = try jsonDecoder.decode(T.self, from: data)
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
}
