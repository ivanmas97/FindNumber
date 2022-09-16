//
//  YellowViewController.swift
//  FindNumber
//
//  Created by Ivan Maslov on 16.09.2022.
//

import UIKit

class YellowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("YellowViewController viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("YellowViewController viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("YellowViewController viewDidAppear")
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("YellowViewController viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("YellowViewController viewDidDisappear")
    }
    
    deinit {
        print("YellowViewController deinit")
    }
    
    
    @IBAction func goToBlueController(_ sender: Any) {
        performSegue(withIdentifier: "goToBlue", sender: "Test String")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToBlue":
            if let blueVC = segue.destination as? BlueViewController {
                if let string = sender as? String {
                blueVC.textForLabel = string
            }
            }
        default:
            break
        }
    }
}
