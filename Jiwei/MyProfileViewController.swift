//
//  MyProfileViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 18/1/2022.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var accountLabel: UITextField!
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var majorLabel: UITextField!
    
    @IBOutlet weak var addressLabel: UITextField!
    
    @IBOutlet weak var birthdayLabel: UITextField!
    
    @IBOutlet weak var qqLabel: UITextField!
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var phoneLabel: UITextField!
    
    @IBOutlet weak var wechatLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        getMyInfo()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmClick(_ sender: UIButton) {
        let alertController = UIAlertController(title: "修改个人信息", message: "修改成功", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true)
    }
    
    
    func getMyInfo() {
        JiweiAPI.renew(completion: { () -> () in
            let complete = {(result: MyInfoResponse) -> (Void) in
                self.accountLabel.text = result.account
                self.nameLabel.text = result.name
                self.majorLabel.text = result.major
                self.addressLabel.text = result.address
                self.birthdayLabel.text = result.birthday
                self.qqLabel.text = result.qq
                self.emailLabel.text = result.email
                self.phoneLabel.text = result.phone
                self.wechatLabel.text = result.weChat
                
            }
            JiweiAPI.getMyInfo(completion: complete)
        })
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
