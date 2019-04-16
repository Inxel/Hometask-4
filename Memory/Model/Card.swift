//
//  Card.swift
//  Memory
//
//  Created by Tyoma Zagoskin on 29/03/2019.
//  Copyright © 2019 Тёма Загоскин. All rights reserved.
//

import Foundation

struct Card {
    
    var isMatched = false
    var isFaceUp = false
    var id: Int
    
    static var lastIdentifier = -1
    
    static func getUniqueIdentifier() -> Int {
        lastIdentifier += 1
        
        return lastIdentifier
    }
    
    init() {
        self.id = Card.getUniqueIdentifier()
    }
    
}
