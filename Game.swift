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
    case win
}


class Game{
    
    struct Item{
        var title: String
        var isFound: Bool = false
        
    }
    
    private let data = Array(1...99)
    
    var items: [Item] = []
    
    private var countItems: Int
    
    var nextItem: Item?
    
    var status: StatusGame = .Start
    
    init(countItems: Int) {
        self.countItems = countItems
        setupGame()
    }
    
    private func setupGame() {
        var digits = data.shuffled()
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
            
        }
        
        nextItem = items.shuffled().first
    }
    
    func check(index: Int) {
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        }
        
        if nextItem == nil {
            status = .win
        }
    }
}
