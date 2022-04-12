//
//  ViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 16/1/2022.
//

import UIKit
import Alamofire
import KeychainAccess

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        getPassword()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwdSwitch: UISwitch!
    
    @IBAction func passwdSwitchChanged(_ sender: UISwitch) {
        if passwdSwitch.isOn {
            print("记住密码开关打开")
            savePassword()
        } else {
            print("记住密码开关关闭")
            let keys = Keychain(service: "org.vincenttsang.scaujiwei-client").allKeys()
            for key in keys {
                print("key: \(key)")
                removePassword(key: key)
            }
        }
    }
    
    private func getPassword() {
        let keychain = Keychain(service: "org.vincenttsang.scaujiwei-client")
        let keys = keychain.allKeys()
        if keys.isEmpty {
            print("Keychain中保存的密码为空")
            print("记住密码开关关闭")
            passwdSwitch.isOn = false
            return
        } else {
            print("记住密码开关打开")
            passwdSwitch.isOn = true
            for key in keys {
                username.text = key
                do {
                    try password.text = keychain.get(key)
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    
    private func savePassword() {
        let passwordMD5 = password.text!
        let account = username.text!
        let keychain = Keychain(service: "org.vincenttsang.scaujiwei-client")
        do {
            try keychain.set(passwordMD5, key: account)
        }
        catch let error {
            print(error)
        }
    }
    
    private func removePassword(key: String) {
        let keychain = Keychain(service: "org.vincenttsang.scaujiwei-client")
        do {
            try keychain.remove(key)
        } catch let error {
            print("error: \(error)")
        }
    }
    
    @IBAction func loginAction(sender: UIButton) {
        var msg: String = ""
        var title: String = ""
        
        let LoginComplete = {(result: LoginResponse?) -> Void in
            
            if(result == nil) {
                title = "登录失败"
                msg = "无法连接至服务器"
                
                let alertController = UIAlertController(title: title, message: msg , preferredStyle: UIAlertController.Style.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            if result!.statusCode == "200" {
                title = "登录成功"
                msg = "用户名: \(result!.name ?? "null")\n角色: \(result!.role ?? "null")"
            } else {
                title = "登录失败"
                msg = "用户名: \(result!.name ?? "null")\n状态码: \(result!.statusCode ?? "null")"
            }
            
            let alertController = UIAlertController(title: title, message: msg , preferredStyle: UIAlertController.Style.alert)
            
            alertController.addAction(UIAlertAction(title: "好的", style: UIAlertAction.Style.default, handler: { action in
                if result!.statusCode == "200" {
                    self.goToTabBarController()
                }
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        JiweiAPI.login(account: username.text ?? "null", passwordMD5: password.text ?? "null", completion: LoginComplete)
        
        //JiweiAPI.login(account: "202025220426", passwordMD5: "000000", completion: LoginComplete)
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
