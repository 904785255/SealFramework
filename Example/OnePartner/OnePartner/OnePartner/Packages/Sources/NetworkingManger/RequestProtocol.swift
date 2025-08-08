//
//  File.swift
//  Packages
//
//  Created by bin sun on 2025/8/7.
//

import Foundation
import Combine

public typealias HttpHeaders    = [String: String]
public typealias HttpParameters = [String: String]


public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case options = "OPTIONS"
}

public protocol RequestProtocol {
    var baseURL: String {get}
    var scheme: String {get}
    var path: String {get}
    var method: HttpMethod { get }
    var headers: HttpHeaders? { get }
    var parameter: HttpParameters? { get}
    var shouldCache: Bool {get}
}

public extension RequestProtocol {
    var scheme: String {
        return "https"
    }
    var baseURL: String {
        return "api.github.com"
    }
    var headers: HttpHeaders? {
        return ["Accept": "application/json"]
    }
    var shouldCache: Bool {
        return false
    }
    
    var request: URLRequest {
        var component: URLComponents = URLComponents()
        
        component.scheme = self.scheme
        component.host   = self.baseURL
        component.path   = self.path
        parameter?.forEach {
            if component.queryItems == nil {
                component.queryItems = []
            }
            component.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        let url = component.url!

        var urlRequest = URLRequest(url: url, cachePolicy: shouldCache ? .useProtocolCachePolicy : .reloadIgnoringLocalCacheData)
        urlRequest.httpMethod = self.method.rawValue

        headers?.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        if self.method == .post {
            let httpBody = try? JSONSerialization.data(withJSONObject: self.parameter ?? [:], options: [])
            urlRequest.httpBody = httpBody
        }
        return urlRequest
    }
    
    
}

