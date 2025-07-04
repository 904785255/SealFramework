//
//  NetworkError.swift
//  OnePartner
//
//  Created by bin sun on 2025/7/4.
//

import Foundation
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingFailed(Error)
    case unauthorized
    case serverError(Int)
    case noInternetConnection
    case requestTimeout
    case unknown(Error?)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "提供的URL无效"
        case .invalidResponse:
            return "服务器返回了无效的响应"
        case .invalidData:
            return "接收到的数据无效"
        case .decodingFailed(let error):
            return "数据解码失败: \(error.localizedDescription)"
        case .unauthorized:
            return "未经授权的访问，请登录"
        case .serverError(let code):
            return "服务器错误 (状态码: \(code))"
        case .noInternetConnection:
            return "网络连接不可用，请检查您的网络设置"
        case .requestTimeout:
            return "请求超时，请稍后再试"
        case .unknown(let error):
            return error?.localizedDescription ?? "发生未知错误"
        }
    }
    
    static func from(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 400...499:
            return statusCode == 401 ? .unauthorized : .invalidResponse
        case 500...599:
            return .serverError(statusCode)
        default:
            return .unknown(nil)
        }
    }
}
