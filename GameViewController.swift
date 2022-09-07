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
    
    lazy var game = Game(countItems: buttons.count, time: 10, mistakes: 0) { [weak self] status, seconds in
        
        guard let self = self else {return}
        
        self.timerLabel.text = "Time left: \(seconds.secondsToString())"
        self.updateGameInfo(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden == true
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
        case .Loose:
            statusLabel.text = "You loose..."
            statusLabel.textColor = .systemRed
            newGameButton.isHidden = false
        }
    }
}
