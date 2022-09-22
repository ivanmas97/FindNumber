//
//  Game.swift
//  FindNumber
//
//  Created by Ivan Maslov on 02.09.2022.
//

import Foundation
import UIKit

enum StatusGame {
    case Start
    case Win
    case Loose
}


class Game{
    
    struct Item{
        var title: String
        var isFound = false
        var isError = false
        
    }
    
    private let data = Array(1...99)
    
    var items: [Item] = []
    
    private var countItems: Int
    
    var nextItem: Item?
    
    var status: StatusGame = .Start {
        didSet {
            if status != .Start {
                stopGame()
            }
        }
    }
    
    private var secondsGame: Int {
        didSet {
            if secondsGame == 0 {
                status = .Loose
            }
            updateTimer(status, secondsGame)
        }
    }
    
    private var timer: Timer?
    
    private var timeForGame: Int
    
    var mistakes: Int
    
    private var updateTimer:((StatusGame, Int) -> Void)
    
    init(countItems: Int, mistakes: Int, updateTimer:@escaping (_ status: StatusGame, _ seconds: Int) -> Void) {
        self.countItems = countItems
        self.timeForGame = Settings.shared.currentSettings.timeForGame
        self.secondsGame = self.timeForGame
        self.updateTimer = updateTimer
        self.mistakes = 0
        setupGame()
    }
    
    private func setupGame() {
        var digits = data.shuffled()
        items.removeAll()
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
        
        updateTimer(status, secondsGame)
        
        if Settings.shared.currentSettings.timerSelected {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self](_) in
                self?.secondsGame -= 1
            })
        }
    }
    
    func newGame() {
        status = .Start
        self.secondsGame = self.timeForGame
        
        setupGame()
    }
    
    func check(index: Int) {
        guard status == .Start else {return}
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        } else {
            items[index].isError = true
            mistakes += 1
        }
        
        if nextItem == nil {
            status = .Win
        }
    }
    
    func stopGame() {
        timer?.invalidate()
    }
}

extension Int {
    func secondsToString() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
