//
//  ResponseStructures.swift
//  Jiwei
//
//  Created by Vincent Tsang on 17/1/2022.
//

import Foundation

var defString = String(stringLiteral: "")
var defInt = -1

struct Member: Codable, CustomStringConvertible {
    var statusCode: String?
    var message: String?
    var name: String?
    var role: String?
    
    var description: String {
        return """
        statusCode = \(statusCode ?? defString)
        message = \(message ?? defString)
        name = \(name ?? defString)
        role = \(role ?? defString)
        """
    }
}
