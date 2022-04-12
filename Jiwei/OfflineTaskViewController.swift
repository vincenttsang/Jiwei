//
//  OfflineTaskViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 12/4/2022.
//

import UIKit

class OfflineTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getOfflineTaskList()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    func getOfflineTaskList() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        JiweiAPI.renew(completion: { () -> () in
            let complete = {(result: UniversalTaskListResponse?) -> (Void) in
                if(result == nil) {
                    return
                } else if(result!.data == nil) {
                    return
                }
                for i in (result!.data!) {
                    print(i?.name ?? "null")
                    print(i?.description ?? "null")
                }
            }
            JiweiAPI.getTaskListByParam(pageNum: 1, limit: INT32_MAX, method: "线下", completion: complete)
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
