//
//  LoginAPI.swift
//  Jiwei
//
//  Created by Vincent Tsang on 18/1/2022.
//

import Foundation
import Alamofire

var GlobalCookie: String = ""

class LoginAPI {
    private let API = "http://127.0.0.1:8080/member/login"
    private var Cookie: String = "null"
    
    public func TryLogin(username: String, password: String) -> Login {
        var loginResult = Login()
        guard let url = URL(string: API) else { return loginResult }
        let uuid = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        let cookie = "JSESSIONID=76978711D8AAFF4606AE7DD624660C4B" // Buggy
        //let cookie = "JSESSIONID=" + uuid
        print(cookie)
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            semaphore.signal()
        }
        
        let rest = RestManager()
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.requestHttpHeaders.add(value: cookie, forKey: "Cookie")
        
        rest.httpBodyParameters.add(value: username, forKey: "account")
        rest.httpBodyParameters.add(value: password, forKey: "passwordMD5")
        rest.httpBodyParameters.add(value: "", forKey: "role")
        rest.makeRequest(toURL: url, withHttpMethod: .post) {
            (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                guard let data = results.data else { return }
                let decoder = JSONDecoder()
                guard let ResultObject = try? decoder.decode(Login.self, from: data) else { return }
                debugPrint(ResultObject.description)
                self.Cookie = cookie
                GlobalCookie = cookie
                loginResult = ResultObject
                let cookieName = "MYCOOKIE"
                if let cookie = HTTPCookieStorage.shared.cookies?.first(where: { $0.name == cookieName }) {
                    debugPrint("\(cookieName): \(cookie.value)")
                }
                
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        return loginResult
    }
    
    public func getNewCookie(username: String, password: String) -> String {
        let login = TryLogin(username: username, password: password)
        if(login.statusCode == "200") {
            return Cookie
        }
        return "null"
    }
}
