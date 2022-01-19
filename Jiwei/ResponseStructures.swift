//
//  ResponseStructures.swift
//  Jiwei
//
//  Created by Vincent Tsang on 17/1/2022.
//

import Foundation

var defString = String(stringLiteral: "")
var defInt = -1

struct Login: Codable, CustomStringConvertible {
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

struct MyInfo: Codable, CustomStringConvertible {
    var account: String?
    var name: String?
    var major: String?
    var address: String?
    var birthday: String?
    var qq: String?
    var email: String?
    var phone: String?
    var weChat: String?
    
    var description: String {
        return """
        account = \(account ?? defString)
        name = \(name ?? defString)
        major = \(major ?? defString)
        address = \(address ?? defString)
        birthday = \(birthday ?? defString)
        qq = \(qq ?? defString)
        email = \(email ?? defString)
        phone = \(phone ?? defString)
        weChat = \(weChat ?? defString)
        """
    }
}
