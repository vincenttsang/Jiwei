//
//  MyTaskViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 31/1/2022.
//

import UIKit

class MyTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getMyTaskList()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var test: UITextView!
    
    func getMyTaskList() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        JiweiAPI.renew(completion: { () -> () in
            let complete = {(result: MyTaskListResponse?) -> (Void) in
                let data = try! encoder.encode(result)
                self.test.text = String(data: data, encoding: .utf8)!
                print(self.test.text!)
            }
            JiweiAPI.getMyTaskList(completion: complete)
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
