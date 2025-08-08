//
//  File.swift
//  Packages
//
//  Created by bin sun on 2025/8/7.
//

import Foundation
public enum NetworkError: Error, LocalizedError {
    case noConnetion

    case invalidURL
    case invalidResponse
    case invalidData
    case decodingFailed(Error)
    case unauthorized
    case code
    case serverError(Int)
    case noInternetConnection
    case requestTimeout
    case unknown(Error?)
    public var errorDescription: String? {
        switch self {
        case .noConnetion:
            return "无链接"
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
        case .code:
            return "解析获取code错误"
        case .requestTimeout:
            return "请求超时，请稍后再试"
        case .unknown(let error):
            return error?.localizedDescription ?? "发生未知错误"
        }
    }
    
    public static func from(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 400...499:
            _ =
            """
            |------------|------------------|---------------------------------
            |    400     | Bad Request      |  请求参数错误，需检查请求体格式
            |------------|------------------|---------------------------------
            |    401     | Unauthorized     |  身份验证失败，需刷新令牌或重新登录
            |------------|------------------|---------------------------------
            |    403     | Forbidden        |  权限不足，需提示用户检查访问权限
            |------------|------------------|---------------------------------
            |    404     | Not Found        |  资源不存在，需更新客户端资源路径
            |------------|------------------|---------------------------------
            |    429     | Too Many Requests|  配合Retry-After头实现限流重试
            |------------|------------------|---------------------------------
            """
            return statusCode == 401 ? .unauthorized : .invalidResponse
        case 500...599:
            _ =
            """
            |------------|--------------------|---------------------------------
            |    500     | Internal Error     | 记录错误日志并提示用户稍后重试
            |------------|--------------------|---------------------------------
            |    502     | Bad Gateway        | 网关问题，可尝试备用API端点
            |------------|--------------------|---------------------------------
            |    503     | Service Unavailable| 服务熔断，显示维护页面
            |------------|--------------------|---------------------------------
            """
            _ = "服务器错误（5xx）‌"
            return .serverError(statusCode)
        default:
            return .unknown(nil)
        }
    }
}
