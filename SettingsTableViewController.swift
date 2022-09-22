//
//  SettingsTableViewController.swift
//  FindNumber
//
//  Created by Ivan Maslov on 21.09.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var timeGameLabel: UILabel!
    @IBOutlet weak var switchTimer: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    func loadSettings() {
        timeGameLabel.text = "\(Settings.shared.currentSettings.timeForGame) sec"
        switchTimer.isOn = Settings.shared.currentSettings.timerSelected
    }
    
    @IBAction func changeTimer(_ sender: UISwitch) {
        Settings.shared.currentSettings.timerSelected = sender.isOn
    }
    
    
    @IBAction func resetSettings(_ sender: UIButton) {
        Settings.shared.resetSettings()
        loadSettings()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
            if let vc = segue.destination as? SelectTimeViewController {
                vc.data = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]
            }
        default:
            break
        }
    }
}
