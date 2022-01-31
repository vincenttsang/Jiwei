//
//  MyProfileViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 18/1/2022.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var Test: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyInfo()
        // Do any additional setup after loading the view.
    }
    
    func getMyInfo() {
        JiweiAPI.renew(completion: { () -> () in
            let complete = {(result: MyInfoResponse) -> (Void) in
                self.Test.text = result.description
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
