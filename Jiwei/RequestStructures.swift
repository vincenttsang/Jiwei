//
//  RequestStructures.swift
//  Jiwei
//
//  Created by Vincent Tsang on 31/1/2022.
//

import Foundation

struct LoginRequest: Codable {
    var account: String?
    var passwordMD5: String?
}
