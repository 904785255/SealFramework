//
//  File.swift
//  Packages
//
//  Created by bin sun on 2025/6/23.
//

import Foundation
public struct MyLogger {
    var DEBUG: Bool = false
    
    // 这里是 struct，所以按照 swift 的 struct 语法，可以不写 init，
    // 但是，因为是封装成 SPM 库，需要对外暴露，
    // 所以 init 构造器不能默认不写，一定需要有 public 构造器，否则外部无法初始化
    public init() {
        
    }
    
    public init(_ DEBUG: Bool) {
        self.DEBUG = DEBUG
    }
    
    public func log(_ msg: String) {
        if DEBUG {
            print("Logger\t\(msg)")
        }
    }
}
