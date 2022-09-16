//
//  BlueViewController.swift
//  FindNumber
//
//  Created by Ivan Maslov on 16.09.2022.
//

import UIKit

class BlueViewController: UIViewController {

    
    @IBOutlet weak var testLabel: UILabel!
    var textForLabel = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = textForLabel
    }
    
    
    @IBAction func goToGreenController(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "greenVC") as? GreenViewController {
            vc.textFotLabel = "Test String"
            vc.title = "Green"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
