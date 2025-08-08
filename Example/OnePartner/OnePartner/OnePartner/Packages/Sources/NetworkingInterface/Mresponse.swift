//
//  File.swift
//  Packages
//
//  Created by bin sun on 2025/8/8.
//

import Foundation
import ReerCodable

@Codable
public struct Mresponse<T: Codable> :Codable{
    var has_more : Bool = false

    var offset   : Int  = 0

    @FlexibleType
    public var code     : String?
    
    public var data     : T?
    public var msg      : String?
    public var token    : String?

}

