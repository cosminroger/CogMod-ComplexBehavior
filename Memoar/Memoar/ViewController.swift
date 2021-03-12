//
//  ViewController.swift
//  memory
//
//  Created by Mark on 02/02/2021.
//

import UIKit

class ViewController: UIViewController {

    lazy var game: Memoar = Memoar()
    var modelArray = [memoarModel(), memoarModel(), memoarModel()]
    
    var turn = 0 {
        willSet {
            userIcons[turn].image = UIImage(named: "parrot\(turn+1)")
        }
        didSet {
            userIcons[turn].image = UIImage(named: "parrot\(turn+1)_turn")
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var pileButtons: [UIButton]!
    
    @IBOutlet var userIcons: [UIImageView]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if turn == 0 {
            let cardNr = cardButtons.firstIndex(of: sender)!
            let button = cardButtons[cardNr]
            
            if button.currentImage == UIImage(named: "back") {
                flipCard(at: cardNr)
                
                if game.matchingCard(card1: game.lastCard, card2: cardNr , player: 0) {
                
                    for player in game.players {
                        turn+=1
                        let model = modelArray[player-1]
                        // Check all unflipped cards, after they are shuffled
                        game.closedCards.shuffle()
                        
                        var answer = ""
                        for card in game.closedCards {
                            // cardNr is the number of the unflipped card
                            // lastAnimal is the animal from the last flipped card
                            // lastBackground is the background of the last flipped card
                            answer = model.checkCard(cardNr: card, lastAnimal: game.lastCard.animal, lastBackground: game.lastCard.background) ?? ""
                            print(answer)
                            
                            if answer == "animalMatch" || answer == "backgroundMatch" {
                                print("FOUND A CARD!!!")
                                break
                            }
                        }
                        
                        // If there is any card to flip, then choose one
                        if let model_choice = game.closedCards.randomElement() {
                            flipCard(at: model_choice)
                            
                            if !game.matchingCard(card1: game.lastCard, card2: model_choice, player: player) {
                                draw_vulcano(player: player)
                            }
                        // Else, draw a volcano (no cards are unflipped)
                        } else {
                            game.players.remove(at: game.players.firstIndex(of: player)!)
                        }
                    }
                    turn = 0
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
                    
                    // For the model, when the player is out
                    
                    while game.closedCards.count > 0 {
                        if game.players.count < 2 {
                            break
                        }
                        
                        for player in game.players {
                            if game.players.count < 2 {
                                break
                            }
                            
                            // For loop through all unflipped cards
                            
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
            print(game.treasures)
            if index < 3 {
                pileButtons[index].setImage(UIImage(named: "vulcano\(game.vulcanos[index])"), for: .normal)
            } else {
                let treasure = game.treasures[index - 3]
                print("tr:",index,treasure)
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
        let vulcano = -1 + self.game.failed_players
        let y_change = self.game.y_changes[player]
        let x_change = self.game.x_changes[player]
        UIView.animate(withDuration:2, animations: {self.pileButtons[vulcano].frame.origin.y=CGFloat(y_change);self.pileButtons[vulcano].frame.origin.x=CGFloat(x_change)})
        print(self.pileButtons[vulcano].frame.origin)
    }
    
    func draw_treasure(player: Int) {
        let treasure = 2 + game.round
        let y_change = self.game.y_changes[player+4]
        let x_change = self.game.x_changes[player+4]
        UIView.animate(withDuration:2, animations: {self.pileButtons[treasure].frame.origin.y=CGFloat(y_change);self.pileButtons[treasure].frame.origin.x=CGFloat(x_change)})
    }
    
    func flipCard(at cardNr: Int) {
        
        for player in game.players{
            let model = modelArray[player-1]
            model.memorizeCard(cardNo: cardNr,animal: game.cards[cardNr].animal, background: game.cards[cardNr].background)
        }
        
        
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
        for i in 0...2 {
            UIView.animate(withDuration:1, animations: {self.pileButtons[i].frame.origin.y=369;self.pileButtons[i].frame.origin.x=549})
            pileButtons[i].setImage(UIImage(named: "vulcano\(game.vulcanos[i])"), for: .normal)
        }
    }
}

