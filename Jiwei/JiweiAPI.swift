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
            if response.data != nil {
                let ResultObject = try? decoder.decode(LoginResponse.self, from: response.data!)
                if ResultObject != nil {
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
        if login_params != nil {
            AF.request(api_url + "/member/login", method: .post, parameters: login_params, encoder: JSONParameterEncoder.default).response { response in
                if response.data != nil {
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
            if response.data != nil {
                let ResultObject = try? decoder.decode(MyInfoResponse.self, from: response.data!)
                if ResultObject != nil {
                    completion(ResultObject!)
                }
            }
        }
    }
    
    public static func getMyTaskList(completion: @escaping (MyTaskListResponse?) -> (Void)) {
        let decoder = JSONDecoder()
        AF.request(api_url + "/member/getMyTaskList", method: .post, parameters: "", encoder: JSONParameterEncoder.default).response { response in
            if response.data != nil {
                let ResultObject = try? decoder.decode(MyTaskListResponse.self, from: response.data!)
                if ResultObject != nil {
                    completion(ResultObject!)
                }
            }
        }
    }
    
    public static func getAllTaskList(completion: @escaping (UniversalTaskListResponse?) -> (Void)) {
        let decoder = JSONDecoder()
        let parameters: [String: Int32] = [
            "page": 1,
            "limit": INT32_MAX
        ]
        AF.request(api_url + "/member/getTaskByParam", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).response { response in
            if response.data != nil {
                let ResultObject = try? decoder.decode(UniversalTaskListResponse.self, from: response.data!)
                if ResultObject != nil {
                    completion(ResultObject!)
                }
            }
        }
    }
    
    public static func getAllTaskList(pageNum: Int32, limit: Int32, completion: @escaping (UniversalTaskListResponse?) -> (Void)) {
        let decoder = JSONDecoder()
        let parameters: [String: Int32] = [
            "page": pageNum,
            "limit": limit
        ]
        AF.request(api_url + "/member/getTaskByParam", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).response { response in
            if response.data != nil {
                let ResultObject = try? decoder.decode(UniversalTaskListResponse.self, from: response.data!)
                if ResultObject != nil {
                    completion(ResultObject!)
                }
            }
        }
    }
    
    public static func getAllTaskList(pageNum: Int32, completion: @escaping (UniversalTaskListResponse?) -> (Void)) {
        let decoder = JSONDecoder()
        let parameters: [String: Int32] = [
            "page": pageNum,
            "limit": 20
        ]
        AF.request(api_url + "/member/getTaskByParam", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).response { response in
            if response.data != nil {
                let ResultObject = try? decoder.decode(UniversalTaskListResponse.self, from: response.data!)
                if ResultObject != nil {
                    completion(ResultObject!)
                }
            }
        }
    }
    
    /*
     getTaskListByParam(pageNum: Int32, limit: Int32, status: String = "", method: String = "", startdate: String = "", enddate: String = "", completion: @escaping (UniversalTaskListResponse?) -> (Void))
     status: 选传 任务状态可选传“未处理 处理中 已完成 取消” 不传默认返回全部
     method: 选传 线上or线下 不传默认返回全部
     startdate: 选传 任务开始时间 格式"YYYY-MM-DD"
     enddate: 选传 任务结束时间 格式"YYYY-MM-DD"
     */
    public static func getTaskListByParam(pageNum: Int32, limit: Int32, status: String = "", method: String = "", startdate: String = "", enddate: String = "", completion: @escaping (UniversalTaskListResponse?) -> (Void)) {
        
        struct RequestParameters : Codable {
            let page: Int32
            let limit: Int32
            let status: String
            let method: String
            let startdate: String
            let enddate: String
        }
        
        let decoder = JSONDecoder()
        let parameters = RequestParameters(page: pageNum, limit: limit, status: status, method: method, startdate: startdate, enddate: enddate)
        AF.request(api_url + "/member/getTaskByParam", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).response { response in
            if response.data != nil {
                let ResultObject = try? decoder.decode(UniversalTaskListResponse.self, from: response.data!)
                if ResultObject != nil {
                    completion(ResultObject!)
                }
            }
        }
    }
    
    public static func getThingList(completion: @escaping (ItemList?) -> (Void)) {
        let decoder = JSONDecoder()
        let parameters: [String: Int32] = [
            "page": 1,
            "limit": 100
        ]
        AF.request(api_url + "/member/getThingList", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).response { response in
            if(response.data != nil) {
                let ResultObject = try? decoder.decode(ItemList.self, from: response.data!)
                if(ResultObject != nil) {
                    completion(ResultObject!)
                }
            }
        }
    }
    
}
