//
//  File.swift
//  Packages
//
//  Created by bin sun on 2025/8/7.
//

import Foundation
import Combine

@MainActor public var cancellables = Set<AnyCancellable>()

public protocol NetworkingProtocol: RequestProtocol, ResponseProtocol {}
extension NetworkingProtocol {
    public func performRequest<T: Codable>(model: T.Type) -> AnyPublisher<Mresponse<T>, NetworkError> {
        let isConnected = true
        guard isConnected else {
            return Fail(error: .noConnetion).eraseToAnyPublisher()
        }
        let decoder = JSONDecoder()
        print("request-\(request)")
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .retry(1)
            .tryMap { data, response in
                print("response=\(response)")
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                print("[httpResponse.statusCode]=\(httpResponse.statusCode)")
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.from(statusCode: httpResponse.statusCode)
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("json=\(json)")

                    let code = json?["code"].map(String.init(describing:)) ?? ""
                    if self.code.contains(code) {
                        return data
                    }else{
                        throw NetworkError.code
                    }
                } catch {
                    throw NetworkError.decodingFailed(error)
                }
            }
            .decode(type: Mresponse<T>.self, decoder: decoder)
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if let decodingError = error as? DecodingError {
                    return .decodingFailed(decodingError)
                } else {
                    return .unknown(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}



