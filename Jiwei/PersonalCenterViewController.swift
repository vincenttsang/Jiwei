//
//  PersonalCenterViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 17/1/2022.
//

import UIKit

class PersonalCenterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //A个人信息 B我的任务
    @IBOutlet weak var containerViewA: UIView!
    @IBOutlet weak var containerViewB: UIView!
    
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 0.5, animations: {
                            self.containerViewA.alpha = 1
                            self.containerViewB.alpha = 0
                        })
        case 1:
            UIView.animate(withDuration: 0.5, animations: {
                            self.containerViewA.alpha = 0
                            self.containerViewB.alpha = 1
                        })
        default:
            print("default")
        }
    }
}
