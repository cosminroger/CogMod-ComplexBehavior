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
            updateView(at: cardNr)
        }
    }
    
    func updateView(at index: Int) {
        let button = cardButtons[index]
        let card = game.cards[index]
        if card.isFaceUp {
            button.setImage(UIImage(named: "\(card.animal)\(card.background)"), for: .normal)
            UIView.transition(with: button, duration: 0.25, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        } else {
            button.setImage(UIImage(named: "back"), for: .normal)
            UIView.transition(with: button, duration: 0.25, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
}

