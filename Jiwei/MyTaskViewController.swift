//
//  MyTaskViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 31/1/2022.
//

import UIKit

class MyTaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: [String] = []
    var finishedTasks:Int = 0
    var cancelledTasks:Int = 0
    var ongoingTasks:Int = 0
    var totalTasks:Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.data[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getMyTaskList()
        self.myTaskTableView.dataSource = self
        self.myTaskTableView.delegate = self
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var myTaskTableView: UITableView!
    
    let startDate:String = "2021-09-01"
    
    func getMyTaskList() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        JiweiAPI.renew(completion: { () -> () in
            let complete = {(result: MyTaskListResponse?) -> (Void) in
                self.myTaskTableView.reloadData()
                if(result == nil) {
                    return
                } else if(result!.data == nil) {
                    return
                }
                for i in (result!.data!) {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let taskInterval = (dateFormatter.date(from: i?.startDate ?? "1970-01-01")?.timeIntervalSince1970) ?? 0
                    let startInterval = (dateFormatter.date(from: self.startDate)?.timeIntervalSince1970) ?? 0
                    if taskInterval < startInterval {
                        //如果该任务日期小于startDate，跳过这次循环
                        continue
                    }
                    if((i?.name) != nil) {
                        self.myTaskTableView.reloadData()
                        let task = "编号: " + ((i?.id)!) + "    称呼: " + ((i?.name)!) + "    状态: " + ((i?.status)!)
                        self.totalTasks += 1
                        if((i?.status)! == "已完成") {
                            self.finishedTasks += 1
                        } else if ((i?.status)! == "处理中") {
                            self.ongoingTasks += 1
                        } else if ((i?.status)! == "取消") {
                            self.cancelledTasks += 1
                        }
                        
                        self.data.append(task)
                    }
                }
                self.myTaskTableView.performBatchUpdates({
                    self.myTaskTableView.insertRows(at: [IndexPath(row: self.data.count - 1, section: 0)], with: .automatic)
                }, completion: nil)
            //self.test.text = String(data: data, encoding: .utf8)!
            }
            JiweiAPI.getMyTaskList(completion: complete)
        })
    }
    
    @IBAction func countMyTasks(_ sender: Any) {
        let title = "我的任务数"
        let completionRate = Double(finishedTasks)/Double(totalTasks - ongoingTasks)
        let msg = "从\(startDate)至今，您总共接下了 " + String(totalTasks) + "个任务\n" + "其中已完成 " + String(finishedTasks) + " 个任务\n" + "已取消 " + String(cancelledTasks) + " 个任务\n" + "有 " + String(ongoingTasks) + " 个任务进行中\n" + "任务完成率为" + String(format: " %.2f%%", completionRate * 100)
        let alertController = UIAlertController(title: title, message: msg , preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "好的", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
