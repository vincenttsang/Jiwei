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
    
    @IBAction func loginAction(sender: UIButton) {
        goToTabBarController()
        var msg:String = ""
        let tryLogin = LoginAPI()
        let LoginResult = tryLogin.TryLogin(username: "114514", password: "000000")
        if LoginResult.statusCode == "200" {
            title = "登录成功"
            msg = "用户名: \(LoginResult.name!)\n角色: \(LoginResult.role!)\nCookie:\(GlobalCookie)"
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
        if let TabBarController =  storyboard?.instantiateViewController(identifier: "HomePage") as? JiweiTabBarController {
            TabBarController.modalPresentationStyle = .fullScreen
            present(TabBarController, animated: true, completion: nil)
        }
    }

}
