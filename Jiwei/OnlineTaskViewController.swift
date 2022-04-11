//
//  OnlineTaskViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 12/4/2022.
//

import UIKit

class OnlineTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.MyTextView.text="此处将显示未处理的线上任务"
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var MyTextView: UITextView!
    
    @IBAction func calNotFinishedTasks(_ sender: Any) {
        self.MyTextView.text = ""
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        var num: UInt32 = 0
        JiweiAPI.renew(completion: { () -> () in
            let complete = {(result: UniversalTaskListResponse?) -> (Void) in
                if(result == nil) {
                    return
                } else if(result!.data == nil) {
                    return
                }
                for i in (result!.data!) {
                    num += 1
                    self.MyTextView.text += "\n"
                    self.MyTextView.text += "任务编号【\((i?.id) ?? "null")】\n"
                    self.MyTextView.text += "姓名： \((i?.name) ?? "null")\n"
                    self.MyTextView.text += "性别： \((i?.sex) ?? "null")\n"
                    self.MyTextView.text += "电话号码： \((i?.telephone) ?? "null")\n"
                    self.MyTextView.text += "地址： \((i?.address) ?? "null")\n"
                    self.MyTextView.text += "电脑型号： \((i?.computerType) ?? "null")\n"
                    self.MyTextView.text += "任务描述： \((i?.description) ?? "null")"
                    self.MyTextView.text += "报修日期： \((i?.startDate) ?? "null")\n"
                }
                let alertController = UIAlertController(title: "统计完成", message: "总共有\(num)个任务未处理" , preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "好的", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            JiweiAPI.getTaskListByParam(pageNum: 1, limit: INT32_MAX, status: "未处理", method: "线上", completion: complete)
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