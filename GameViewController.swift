//
//  GameViewController.swift
//  FindNumber
//
//  Created by Ivan Maslov on 02.09.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var mistakeLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    lazy var game = Game(countItems: buttons.count, mistakes: 0) { [weak self] status, seconds in
        
        guard let self = self else {return}
        
        if Settings.shared.currentSettings.timerSelected {
            self.timerLabel.text = "Time left: \(seconds.secondsToString())"
        } else {
            self.timerLabel.alpha = 0
        }
        self.updateGameInfo(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        game.stopGame()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
//        sender.isHidden == true
        setupScreen()
    }
    
    private func setupScreen() {
        
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].isHidden = false
        }
        
        nextDigit.text = game.nextItem?.title
        
        mistakeLabel.text = "0 mistakes"
    }
    
    private func updateUI() {
        for index in game.items.indices {
            
            if game.items[index].isFound {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .systemGreen
                } completion: { (_) in
                    self.buttons[index].alpha = self.game.items[index].isFound ? 0 : 1
                    self.buttons[index].isEnabled = !self.game.items[index].isFound
                }
            }
            
            if game.items[index].isError {
                mistakeLabel.text = "\(game.mistakes) mistakes"
                
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                } completion: { [weak self] (_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }
            }
        }
        
        nextDigit.text = game.nextItem?.title
        
        updateGameInfo(with: game.status)
    }
    
    private func updateGameInfo(with status: StatusGame) {
        switch status {
        case .Start:
            statusLabel.text = "Game started"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .Win:
            statusLabel.text = "You win!"
            statusLabel.textColor = .systemGreen
            newGameButton.isHidden = false
            if game.isNewRecord {
                showAlert()
            } else {
                showAlertActionSheet()
            }
        case .Loose:
            statusLabel.text = "You loose..."
            statusLabel.textColor = .systemRed
            newGameButton.isHidden = false
            showAlertActionSheet()
        }
    }


    private func showAlert() {
        
        let alert = UIAlertController(title: "Congratulations!", message: "You set the new record", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
        
    }
    private func showAlertActionSheet() {
        
        let alert = UIAlertController(title: "What do you want to do next?", message: nil, preferredStyle: .actionSheet)
        
        let newGameAction = UIAlertAction(title: "Start new game", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        
        let showRecordAction = UIAlertAction(title: "See the record", style: .default) { [weak self] (_) in
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
        }
        
        let menuAction = UIAlertAction(title: "Go to menu", style: .destructive) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(newGameAction)
        alert.addAction(showRecordAction)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = statusLabel
//            popover.sourceView = self.view
//            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
//            popover.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        }
        
        present(alert, animated: true)
    }
    
}
