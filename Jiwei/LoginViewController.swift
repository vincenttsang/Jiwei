//
//  ViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 16/1/2022.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    private let LoginURL = "http://127.0.0.1:8080/member/login"
    
    @IBAction func loginAction(sender: UIButton) {
        guard let url = URL(string: LoginURL) else { return }
        let rest = RestManager()
        var msg: String = ""
        var title: String = ""
        var LoginResult:Member = Member()
        
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            msg = "Request timed out for 3000ms!"
            semaphore.signal()
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.httpBodyParameters.add(value: username.text!, forKey: "account")
        rest.httpBodyParameters.add(value: password.text!, forKey: "passwordMD5")
        rest.httpBodyParameters.add(value: "", forKey: "role")
        rest.makeRequest(toURL: url, withHttpMethod: .post) {
            (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                guard let data = results.data else { return }
                let decoder = JSONDecoder()
                guard let ResultObject = try? decoder.decode(Member.self, from: data) else { return }
                print(ResultObject.description)
                LoginResult = ResultObject
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        if LoginResult.statusCode == "200" {
            title = "登录成功"
            msg = "用户名: \(LoginResult.name!)\n角色: \(LoginResult.role!)"
        } else {
            title = "登录失败"
            msg = "\(LoginResult.description)"
        }
        
        let alertController = UIAlertController(title: title, message: msg , preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            if LoginResult.statusCode == "200" {
                self.goToTabBarController()
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    

    @IBAction func signUpAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "用户注册", message: "该功能未开放", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "返回", style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alertController, animated: true)
    }
    
    private func goToTabBarController() {
        if let TabBarController =  storyboard?.instantiateViewController(identifier: "HomePage") {
            TabBarController.modalPresentationStyle = .fullScreen
            present(TabBarController, animated: true, completion: nil)
        }
    }

}
