//
//  ViewController.swift
//  Jiwei
//
//  Created by Vincent Tsang on 16/1/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMessage(sender: UIButton) {
        let alertController = UIAlertController(title: "计维App测试中", message: "App尚未完成", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "啊对对对", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

