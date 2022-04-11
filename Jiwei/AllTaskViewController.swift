//
//  AllTaskViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 19/3/2022.
//

import UIKit

class AllTaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        getAllTaskList()
        self.allTaskTableView.dataSource = self
        self.allTaskTableView.delegate = self
        self.hideKeyboardWhenTappedAround()
        let optionsClosure = { (action: UIAction) in
          print(action.title)
        }
        pageSelector.menu = UIMenu(children: [
          UIAction(title: "Option 1", state: .on, handler: optionsClosure),
          UIAction(title: "Option 2", handler: optionsClosure),
          UIAction(title: "Option 3", handler: optionsClosure),
        ])
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var allTaskTableView: UITableView!
    
    @IBOutlet weak var pageSelector: UIButton!
    
    func getAllTaskList() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        JiweiAPI.renew(completion: { () -> () in
            let complete = {(result: UniversalTaskListResponse?) -> (Void) in
                self.allTaskTableView.reloadData()
                if(result == nil) {
                    return
                } else if(result!.data == nil) {
                    return
                }
                for i in (result!.data!) {
                    if((i?.name) != nil) {
                        self.allTaskTableView.reloadData()
                        let task = "编号: " + ((i?.id)!) + "    " + ((i?.name)!) + "    状态: " + ((i?.status)!)
                        
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
            //self.test.text = String(data: data, encoding: .utf8)!
                self.allTaskTableView.performBatchUpdates({
                   self.allTaskTableView.insertRows(at: [IndexPath(row: self.data.count - 1, section: 0)], with: .automatic)
               }, completion: nil)
            }
            JiweiAPI.getAllTaskList(completion: complete)
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
