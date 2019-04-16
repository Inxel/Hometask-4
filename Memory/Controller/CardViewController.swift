//
//  ViewController.swift
//  Memory
//
//  Created by Tyoma Zagoskin on 29/03/2019.
//  Copyright © 2019 Тёма Загоскин. All rights reserved.
//

import UIKit
import RealmSwift

class CardViewController: UIViewController {
    
    private var realm = try! Realm()
    
    private var game: Memory!
    
    private let emojiList = ["🦊", "🐻", "🐼", "🐨", "🦁", "🐯", "🐵", "🦉", "🦇", "🐝", "🦄", "🐷", "🐣", "🐳", "🦋", "🐹", "🌚", "🦞", "🐙", "🐞", "🐧"]
    private var emojiForCards: [String]!
    private var emoji = [Int:String]()
    
    private var score = 0
    private var seconds = 0
    private var timer = Timer()
    
    private var alert: UIAlertController?
    private var restartAction: UIAlertAction?
    private var cancelAction: UIAlertAction?
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    @IBAction func cardButtonAction(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex, cardButtons)
            addScores(sender)
            updateButtons()
        }
    }
    
    func createAlert() {
        
        alert = UIAlertController(title: "U score \(score) points!", message: "Do you want to restart game?", preferredStyle: .alert)
        
        restartAction = UIAlertAction(title: "Restart", style: .default) { action in
        
            self.newGame()
            
        }
        
        cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
            self.navigationController?.popViewController(animated: true)
        }
        
        alert!.addAction(restartAction!)
        alert!.addAction(cancelAction!)
    }
    
    func updateButtons() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                showCard(button, card)
                if card.isMatched {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                        button.setTitle("", for: .normal)
                        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    }
                }
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
            }
        }
        
        if game.allCardsHaveBeenMatched {
            endOfGame()
        }
        
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emojiForCards.count > 0 {
            let randomIndex = Int.random(in: 0 ..< emojiForCards.count)
            emoji[card.id] = emojiForCards.remove(at: randomIndex)
        }
        
        return emoji[card.id]!
    }
    
    func showCard(_ button: UIButton, _ card: Card) {
        if !cardIsMatched(button) {  // Don't show already matched cards
            button.setTitle(emoji(for: card), for: .normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        timer.invalidate()
        newGame()
    }
    
    func newGame() {
        emojiForCards = emojiList
        game = Memory(numberOfPairsOfCrads: (cardButtons.count + 1) / 2)
        resetResults()
        runTimer()
        updateButtons()
    }

    func endOfGame() {
        createAlert()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700)) {
            self.present(self.alert!, animated: true, completion: nil)
        }
        timer.invalidate()
        saveCurrentGameResults()
    }
    
    func cardIsMatched(_ card: UIButton) -> Bool {
        return card.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    }
    
    //MARK: - Set timer
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(CardViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
}


//MARK: - Results methods

extension CardViewController {
    
    func addScores(_ card: UIButton) {
        if !cardIsMatched(card) {  // don't add scores when tap on matched card
            scoreLabel.text = "Score: \(changeResults(&score))"
        }
    }
    
    @objc func updateTimer() {
        timerLabel.text = "Timer: \(changeResults(&seconds))"
    }
    
    func changeResults(_ property: inout Int) -> Int {
        property = property + 1
        return property
    }
    
    func resetResults() {
        seconds = 0
        timerLabel.text = "Timer: \(seconds)"
        score = 0
        scoreLabel.text = "Score: \(score)"
    }
    
}


//MARK: - Save methods

extension CardViewController {
    
    func saveToRealm(_ results: UserResults) {
        do {
            try realm.write {
                realm.add(results)
            }
        } catch {
            print("Error saving results")
        }
    }
    
    func saveCurrentGameResults() {
        let userResults = UserResults()
        userResults.score = String(score)
        userResults.gameTime = String(seconds)
        
        saveToRealm(userResults)
    }
    
}
