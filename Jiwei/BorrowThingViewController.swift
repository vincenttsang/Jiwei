//
//  BorrowThingViewController.swift
//  
//
//  Created by Vincent Tsang on 4/3/2022.
//

import UIKit

class BorrowThingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: [String] = []
    
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
        getThingList()
        self.borrowThingTableView.dataSource = self
        self.borrowThingTableView.delegate = self
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var borrowThingTableView: UITableView!

    func getThingList() {
        JiweiAPI.renew(completion: { () -> () in
            let complete = {(result: ItemList?) -> (Void) in
                self.borrowThingTableView.reloadData()
                if(result == nil) {
                    return
                } else if(result!.data == nil) {
                    return
                }
                for i in (result!.data!) {
                    if((i?.id) != nil) {
                        self.borrowThingTableView.reloadData()
                        var thing = "编号: " + ((i?.id)!) + "    物品名: " + ((i?.name)!)
                        thing += "    现存数量: " + String((i?.currentAmount)!)
                        self.data.append(thing)
                        self.borrowThingTableView.performBatchUpdates({
                            self.borrowThingTableView.insertRows(at: [IndexPath(row: self.data.count - 1, section: 0)], with: .automatic)
                        }, completion: nil)
                    }
                }
            //self.test.text = String(data: data, encoding: .utf8)!
            }
            JiweiAPI.getThingList(completion: complete)
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
