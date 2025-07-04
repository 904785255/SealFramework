//
//  ApiService.swift
//  OnePartner
//
//  Created by bin sun on 2025/7/4.
//

import Foundation
import Combine
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
class ApiService {
    func fetchData<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
extension ApiService {
    func fetch<T: Decodable>(_ type: T.Type,
                             string:String,
                             method: HTTPMethod = .post,
                             parameters: [String: String]? = nil,requestCallHandle:((URLRequest) -> Void)? = nil) -> AnyPublisher<T, NetworkError> {

        guard let url = URL(string: string) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let headers :[String: String]? = nil
        request.allHTTPHeaderFields = headers
        if method == .get {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = parameters?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            if let urlWithQuery = components?.url {
                request.url = urlWithQuery
            }
        }else{
            let body = try? JSONEncoder().encode(parameters)
            request.httpBody = body
            if let handle = requestCallHandle{
                _ = "查看编码方式"
                let httpBody = try? JSONSerialization.data(withJSONObject: parameters)
                handle(request)
            }
        }
        return URLSession.shared.dataTaskPublisher(for: request).tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            print(httpResponse)
            guard 200...299 ~= httpResponse.statusCode else {
                throw NetworkError.from(statusCode: httpResponse.statusCode)
            }
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                print(json)
            }
            return data
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError { [weak self] error in
            print("error-request-\(error)")
            if let decodingError = error as? DecodingError {
                return NetworkError.decodingFailed(decodingError)
            } else if let networkError = error as? NetworkError {
                return networkError
            } else {
                return NetworkError.unknown(error)
            }
        }
        .eraseToAnyPublisher()
    }
}
struct User: Codable, Identifiable {
    let id: Int
    let name: String
}
