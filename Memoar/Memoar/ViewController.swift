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
        if cardNr < 24 {
            updateView()
        }
    }
    
    func updateView() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setBackgroundImage(UIImage(named: "\(card.animal)\(card.background)"), for: UIControl.State.normal)
            } else {
                button.setBackgroundImage(UIImage(named: "back"), for: UIControl.State.normal)
            }
        }
    }
}

