//
//  ViewController.swift
//  Concentration
//
//  Created by Raven on 2018/9/5.
//  Copyright © 2018 Raven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0  {
        didSet {
            flipLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchButton(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            flipCount+=1
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("no card been chosen")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card),for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle(nil, for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["😈","👽","👻","🎃","🐶","🦀","🐏","🍎","🍭"]
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count>0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}


