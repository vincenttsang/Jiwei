//
//  JiweiAPI.swift
//  Jiwei
//
//  Created by Vincent Tsang on 31/1/2022.
//

import Foundation
import Alamofire

class JiweiAPI {
    
    private static let api_url = "https://www.scaujiwei.com"
    
    //private static let api_url = "http://127.0.0.1:8080"
    
    private static var login_params: LoginRequest? = nil
    
    public static func login(account: String, passwordMD5: String, completion: @escaping (LoginResponse?) -> (Void)) {
        login_params = LoginRequest(account: account, passwordMD5: passwordMD5)
        let decoder = JSONDecoder()
        AF.request(api_url + "/member/login", method: .post, parameters: login_params, encoder: JSONParameterEncoder.default).response { response in
            if(response.data != nil) {
                let ResultObject = try? decoder.decode(LoginResponse.self, from: response.data!)
                if(ResultObject != nil) {
                    completion(ResultObject!)
                } else {
                    completion(nil)
                }
            }
            completion(nil)
        }
    }
    
    public static func renew(completion: @escaping () -> ()) {
        print("Renewing the session...")
        if(login_params != nil) {
            AF.request(api_url + "/member/login", method: .post, parameters: login_params, encoder: JSONParameterEncoder.default).response { response in
                if(response.data != nil) {
                    print("Success!")
                    print(response.data!)
                    completion()
                } else {
                    print("Error: The Server is unreachable.")
                }
            }
        } else {
            print("Error: Missing login parameters!")
        }
    }
    
    public static func getMyInfo(completion: @escaping (MyInfoResponse) -> (Void)) {
        let decoder = JSONDecoder()
        AF.request(api_url + "/member/getMyInfo", method: .post, parameters: "", encoder: JSONParameterEncoder.default).response { response in
            if(response.data != nil) {
                let ResultObject = try? decoder.decode(MyInfoResponse.self, from: response.data!)
                if(ResultObject != nil) {
                    completion(ResultObject!)
                }
            }
        }
    }
    
    public static func getMyTaskList(completion: @escaping (MyTaskListResponse?) -> (Void)) {
        let decoder = JSONDecoder()
        AF.request(api_url + "/member/getMyTaskList", method: .post, parameters: "", encoder: JSONParameterEncoder.default).response { response in
            if(response.data != nil) {
                let ResultObject = try? decoder.decode(MyTaskListResponse.self, from: response.data!)
                if(ResultObject != nil) {
                    completion(ResultObject!)
                }
            }
        }
    }
    
}
