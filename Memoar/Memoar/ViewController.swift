//
//  ViewController.swift
//  memory
//
//  Created by Mark on 02/02/2021.
//

import UIKit

class ViewController: UIViewController {

    lazy var game: Memoar = Memoar()
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if game.turn == 0 {
            let cardNr = cardButtons.firstIndex(of: sender)!
            let button = cardButtons[cardNr]
            if button.currentImage == UIImage(named: "back") {
                flipCard(at: cardNr)
                updateView(at: cardNr)
                if game.matchingCard(card1: game.lastCard, card2: cardNr , player: 0) {
                    for player in game.players {
                        game.turn+=1
                        if let model_choice =
                            game.closedCards.randomElement() {
                            flipCard(at: model_choice)
                            game.matchingCard(card1: game.lastCard, card2: model_choice, player: player)
                        } else {
                            game.players.remove(at: game.players.firstIndex(of: player)!)
                        }
                    }
                    game.turn = 0
                    if game.players.count == 0 {
                        print("you won!")
                        nextRound()
                    } else if game.closedCards.count == 0{
                        if let final_player = game.players.last {
                            print("End of round, player \(final_player) wins!")
                        } else {
                            print("End of round, player you win!")
                        }
                        nextRound()
                    }
                } else {
                    while game.closedCards.count > 0 {
                        if game.players.count < 2 {
                            break
                        }
                        for player in game.players {
                            if game.players.count < 2 {
                                break
                            }
                            if let model_choice =
                                game.closedCards.randomElement() {
                                flipCard(at: model_choice)
                                game.matchingCard(card1: game.lastCard, card2: model_choice, player: player)
                            } else {
                                game.players.remove(at: game.players.firstIndex(of: player)!)
                            }
                        }
                    }
                    print("End of round. player \(game.players[0]) wins")
                    nextRound()
                }
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
        print(cardNr)
        game.chooseCard(at: cardNr)
        updateView(at: cardNr)
    }
    
    func updateView(at index: Int) {
        let button = cardButtons[index]
        let card = game.cards[index]
        if card.isFaceUp {
            button.setImage(UIImage(named: "\(card.animal)\(card.background)"), for: .normal)
            UIView.transition(with: button, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
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

