//
//  AllTaskViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 19/3/2022.
//

import UIKit

class AllTaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var strData: [(String,Int,String)] = [] //所有任务，其中的Int是114为已完成，514为未处理，1919为取消，810为处理中: [(任务信息,Status,任务编号)]
    var finishedTasks:Int = 0
    var viewTasks: [String] = [] //实际显示的任务
    var viewTasksID : [(Int,String)] = [] //实际显示的任务的编号: [(view中第几行,该行对应的任务编号)]
    var cancelledTasks:Int = 0
    var ongoingTasks:Int = 0
    var totalTasks:Int = 0
    var rawData: [Task] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.viewTasks[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        for i in viewTasksID {
            if i.0 == indexPath.row {
                print("任务编号: \(i.1)")
                //let vc = PopUpTaskDetail()
                //AllTaskViewController.present(vc, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTaskList(sync: true)
        self.allTaskTableView.dataSource = self
        self.allTaskTableView.delegate = self
        self.hideKeyboardWhenTappedAround()
                
        let displayAll = { (action: UIAction) in
            print(action.title)
            self.refreshTaskList()
            self.viewTasks = []
            self.viewTasksID = []
            var i = 0
            for ele in self.strData {
                self.viewTasks.append(ele.0)
                self.viewTasksID.append((i,ele.2))
                i += 1
            }
            self.updateTaskListView()
        }
        
        let displayNotHandled = { (action: UIAction) in
            print(action.title)
            self.viewTasks = []
            self.viewTasksID = []
            var i = 0
            for ele in self.strData {
                if ele.1 == 514 {
                    self.viewTasks.append(ele.0)
                    self.viewTasksID.append((i,ele.2))
                    i += 1
                }
            }
            self.updateTaskListView()
        }
        
        let displayFinished = { (action: UIAction) in
            print(action.title)
            self.viewTasks = []
            self.viewTasksID = []
            var i = 0
            for ele in self.strData {
                if ele.1 == 114 {
                    self.viewTasks.append(ele.0)
                    self.viewTasksID.append((i,ele.2))
                    i += 1
                }
            }
            self.updateTaskListView()
        }
        
        let displayProcessing = { (action: UIAction) in
            print(action.title)
            self.viewTasks = []
            self.viewTasksID = []
            var i = 0
            for ele in self.strData {
                if ele.1 == 810 {
                    self.viewTasks.append(ele.0)
                    self.viewTasksID.append((i,ele.2))
                    i += 1
                }
            }
            self.updateTaskListView()
        }
        
        let displayCancelled = { (action: UIAction) in
            print(action.title)
            self.viewTasks = []
            self.viewTasksID = []
            var i = 0
            for ele in self.strData {
                if ele.1 == 1919 {
                    self.viewTasks.append(ele.0)
                    self.viewTasksID.append((i,ele.2))
                    i += 1
                }
            }
            self.updateTaskListView()
        }
        
        pageSelector.menu = UIMenu(children: [
          UIAction(title: "刷新并显示全部任务", state: .on, handler: displayAll),
          UIAction(title: "未处理的任务", handler: displayNotHandled),
          UIAction(title: "处理中的任务", handler: displayProcessing),
          UIAction(title: "已完成的任务", handler: displayFinished),
          UIAction(title: "已取消的任务", handler: displayCancelled),
        ])
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var allTaskTableView: UITableView!
    
    @IBOutlet weak var pageSelector: UIButton!
    
    func updateTaskListView() {
        if !viewTasks.isEmpty {
            self.allTaskTableView.reloadData()
            self.allTaskTableView.beginUpdates()
            self.allTaskTableView.endUpdates()
        }
    }
    
    func syncTasksToStringData(task_array: [Task]) {
        strData = []
        for i in task_array {
            let task = "编号: " + ((i.id)!) + "    " + ((i.name)!) + "    状态: " + ((i.status)!)
            self.totalTasks += 1
            if((i.status)! == "已完成") {
                self.finishedTasks += 1
                self.strData.append((task, 114, i.id ?? "null"))
            } else if ((i.status)! == "处理中") {
                self.ongoingTasks += 1
                self.strData.append((task, 810, i.id ?? "null"))
            } else if ((i.status)! == "取消") {
                self.cancelledTasks += 1
                self.strData.append((task, 1919, i.id ?? "null"))
            } else if((i.status)! == "未处理") {
                self.cancelledTasks += 1
                self.strData.append((task, 514, i.id ?? "null"))
            }
        }
    }
    
    func refreshTaskList(sync: Bool = false) {
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
                    if((i?.name) != nil) {
                        self.rawData.append(i!)
                    }
                }
                if sync {
                    self.syncTasksToStringData(task_array: self.rawData)
                    self.viewTasks = []
                    self.viewTasksID = []
                    var i = 0
                    for ele in self.strData {
                        self.viewTasks.append(ele.0)
                        self.viewTasksID.append((i,ele.2))
                        i += 1
                    }
                    self.updateTaskListView()
                }
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
