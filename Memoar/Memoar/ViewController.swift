//
//  ViewController.swift
//  memory
//
//  Created by Mark on 02/02/2021.
//

import UIKit

class ViewController: UIViewController {

    lazy var game: Memoar = Memoar(NrOfCards:cardButtons.count)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        let cardNr = cardButtons.firstIndex(of: sender)!
        print(cardNr)
        game.chooseCard(at: cardNr)
        updateView()
    }
    
    func updateView() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
        }
    }
    func emoji(for card: Card) -> String {
        return "?"
    }
}

