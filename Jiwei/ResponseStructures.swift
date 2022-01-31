//
//  ResponseStructures.swift
//  Jiwei
//
//  Created by Vincent Tsang on 17/1/2022.
//

import Foundation

var defString = String(stringLiteral: "")
var defInt = -1

struct LoginResponse: Codable, CustomStringConvertible {
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

struct MyInfoResponse: Codable, CustomStringConvertible {
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

struct MyTaskListResponse: Codable {
    var code: Int32?
    var count: Int32?
    var msg: String?
    var data: Array<Task?>?
}

struct Task: Codable {
    var id: String?
    var name: String?
    var sex: String?
    var telephone: String?
    var address: String?
    var description: String?
    var computerType: String?
    var status: String?
    var repairMethod: String?
    var startDate: String?
    var endDate: String?
    var idList: Array<String?>?
    var nameList: Array<String?>?
    var taskLog: [[String:String]]?
    var pictureUrl: Array<String?>?
}
