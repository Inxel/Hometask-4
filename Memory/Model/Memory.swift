//
//  Memory.swift
//  Memory
//
//  Created by Tyoma Zagoskin on 29/03/2019.
//  Copyright © 2019 Тёма Загоскин. All rights reserved.
//

import UIKit

class Memory {
    
    var cards = [Card]()
    
    var indexOfFaceUpCard: Int?
    
    func chooseCard(at index: Int, _ cardButtons: [UIButton]) {
        if cards[index].isMatched {
            return
        }
        
        if let matchIndex = indexOfFaceUpCard, matchIndex != index {
            UIView.transition(with: cardButtons[index], duration: 0.3, options: .transitionFlipFromTop, animations: nil, completion: nil)
            if cards[matchIndex].id == cards[index].id {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                self.flipCard(cardButtons, index)
                self.flipCard(cardButtons, matchIndex)
            }
            indexOfFaceUpCard = nil
        } else {
            for cardIndex in cards.indices {
                cards[cardIndex].isFaceUp = false
            }
            
             UIView.transition(with: cardButtons[index], duration: 0.3, options: .transitionFlipFromTop, animations: nil, completion: nil)
            indexOfFaceUpCard = index
        }
        cards[index].isFaceUp = true
    }
    
    var allCardsHaveBeenMatched: Bool {
        for index in cards.indices {
            if !cards[index].isMatched { return false }
        }
        return true
    }
    
    func flipCard(_ card: [UIButton], _ index: Int) {
        cards[index].isFaceUp = false
        card[index].setTitle("", for: .normal)
        card[index].backgroundColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.transition(with: card[index], duration: 0.3, options: .transitionFlipFromTop, animations: nil, completion: nil)
         UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    init(numberOfPairsOfCrads: Int) {
        for _ in 1 ... numberOfPairsOfCrads {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
}
