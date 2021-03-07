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
    
    @IBOutlet var pileButtons: [UIButton]!
    
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
                            if !game.matchingCard(card1: game.lastCard, card2: model_choice, player: player) {
                                draw_vulcano(player: player)
                            }
                        } else {
                            game.players.remove(at: game.players.firstIndex(of: player)!)
                        }
                    }
                    game.turn = 0
                    if game.players.count == 0 {
                        print("you won!")
                        draw_treasure(player: 0)
                        nextRound()
                    } else if game.closedCards.count == 0{
                        if let final_player = game.players.last {
                            print("End of round, player \(final_player) wins!")
                            draw_treasure(player: final_player)
                        } else {
                            print("End of round, you win!")
                            draw_treasure(player: 0)
                        }
                        nextRound()
                    }
                } else {
                    draw_vulcano(player: 0)
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
                                if !game.matchingCard(card1: game.lastCard, card2: model_choice, player: player) {
                                   draw_vulcano(player: player)
                                }
                            } else {
                                game.players.remove(at: game.players.firstIndex(of: player)!)
                                draw_vulcano(player: player)
                            }
                        }
                    }
                    print("End of round. player \(game.players[0]) wins")
                    draw_treasure(player: game.players[0])
                    nextRound()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in pileButtons.indices{
            print(index)
            print(game.vulcanos)
            if index < 3 {
                pileButtons[index].setImage(UIImage(named: "vulcano\(game.vulcanos[index])"), for: .normal)
            } else {
                let treasure = game.treasures[index - 3]
                pileButtons[index].setImage(UIImage(named: "Treasure\(treasure)"), for: .normal)
            }
        }
        for button in self.cardButtons {
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 1
            button.layer.shadowOffset = CGSize(width: 4, height: 7)
        }
    }
    
    func draw_vulcano(player: Int) {
        if player == 0 {
            
        }
        let vulcano = -1 + self.game.failed_players
        let y_change = -300
        let x_change = 100 * player + 82
        UIView.animate(withDuration:2, animations: {self.pileButtons[vulcano].frame.origin.y-=CGFloat(y_change);self.pileButtons[vulcano].frame.origin.x-=CGFloat(x_change)})
    }
    
    func draw_treasure(player: Int) {
        let treasure = 2 + game.round
        let y_change = -300
        let x_change = 50 * game.round + 82
        UIView.animate(withDuration:2, animations: {self.pileButtons[treasure].frame.origin.y-=CGFloat(y_change);self.pileButtons[treasure].frame.origin.x+=CGFloat(x_change)})
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
        // TODO: return vulcanos
    }
}

