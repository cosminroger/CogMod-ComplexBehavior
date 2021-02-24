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
        if game.turn == 0 {
            let cardNr = cardButtons.firstIndex(of: sender)!
            flipCard(at: cardNr)
            if cardNr < 24 {
                game.turn+=1
                for _ in 0...2 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        if let model_choice = self.game.closedCards.randomElement() {
                            self.flipCard(at: model_choice)
                        } else {
                            print("all cards turned")
                        }
                        self.game.turn += 1
                    })
                    
                }
                game.turn = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in self.cardButtons {
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 1
            button.layer.shadowOffset = CGSize(width: 4, height: 7)
        }
    }
    
    func flipCard(at cardNr: Int) {
        game.chooseCard(at: cardNr)
        if cardNr < 24 {
            updateView(at: cardNr)
        } else {
            nextRound()
        }
    }
    
    func updateView(at index: Int) {
        let button = cardButtons[index]
        let card = game.cards[index]
        if card.isFaceUp {
            button.setImage(UIImage(named: "\(card.animal)\(card.background)"), for: .normal)
            UIView.transition(with: button, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        } else {
            button.setImage(UIImage(named: "back"), for: .normal)
            UIView.transition(with: button, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
    
    func nextRound() {
        game.resetRound()
        for index in cardButtons.indices{
            let button = cardButtons[index]
            button.setImage(UIImage(named: "back"), for: .normal)
            UIView.transition(with: button, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
}

