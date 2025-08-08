//
//  File.swift
//  Packages
//
//  Created by bin sun on 2025/8/7.
//

import Foundation
public protocol ResponseProtocol {
//    associatedtype ResponseType: Decodable
//    func parse(data: Data) throws -> ResponseType
//
    
    var code: [String] {get}

}

public extension ResponseProtocol {
    var code: [String] {
        return ["2000"]
    }
}


