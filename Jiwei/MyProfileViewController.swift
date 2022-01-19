//
//  MyProfileViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 18/1/2022.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var Test: UITextView!
    private let getMyInfoURL = "http://127.0.0.1:8080/member/getMyInfo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyInfo()
        // Do any additional setup after loading the view.
    }
    
    func getMyInfo() {
        guard let url = URL(string: getMyInfoURL) else { return }
        let rest = RestManager()
        var MyInfoResult:MyInfo = MyInfo()
        
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            print("Request timed out for 3000ms!")
            semaphore.signal()
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.requestHttpHeaders.add(value: GlobalCookie, forKey: "Cookie")
        
        rest.makeRequest(toURL: url, withHttpMethod: .post) {
            (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                guard let data = results.data else { return }
                let decoder = JSONDecoder()
                guard let ResultObject = try? decoder.decode(MyInfo.self, from: data) else { return }
                print(ResultObject.description)
                MyInfoResult = ResultObject
            }
            semaphore.signal()
        }
        semaphore.wait()
        Test.text = MyInfoResult.description
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
