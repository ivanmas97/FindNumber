//
//  GreenViewController.swift
//  FindNumber
//
//  Created by Ivan Maslov on 16.09.2022.
//

import UIKit

class GreenViewController: UIViewController {

    
    var textFotLabel = ""
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func goToRoot(_ sender: Any) {
//        self.navigationController?.popToRootViewController(animated: true)
        if let viewControllers = self.navigationController?.viewControllers {
            for vc in viewControllers {
                if vc is YellowViewController {
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
        }
    }
}
