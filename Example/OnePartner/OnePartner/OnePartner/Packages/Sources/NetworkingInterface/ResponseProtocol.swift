//
//  File.swift
//  Packages
//
//  Created by bin sun on 2025/8/7.
//

import Foundation
public protocol ResponseProtocol {
    var code: [String] {get}
}

public extension ResponseProtocol {
    var code: [String] {
        return ["20000"]
    }
}


