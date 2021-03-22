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
    
    var scores = [0,0,0,0] {
        didSet {
            for i in scores.indices {
                scoreLabels[i].text = "\(scores[i])"
            }
        }
    }

    @IBOutlet var scoreLabels: [UILabel]!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var pileButtons: [UIButton]!
    
    @IBOutlet var userIcons: [UIImageView]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if turn == 0 {
            let cardNr = cardButtons.firstIndex(of: sender)!
            let button = cardButtons[cardNr]
            
            if button.currentImage == UIImage(named: "back") { // if card touched is not flipped
                flipCard(at: cardNr)
                if game.matchingCard(card1: game.lastCard, card2: cardNr , player: 0) {
                    self.turn = game.players[0]
                    var delay = 0.0
                    for player in game.players {
                        delay += 1.5
                        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
                            self.turn = player
                            // Check all unflipped cards, after they are shuffled if there are any
                            self.model_turn(player: player)
                        }
                    }
                    Timer.scheduledTimer(withTimeInterval: delay + 1.5, repeats: false) { _ in
                        let game = self.game
                        if game.players.count == 0 {
                            print("you won!")
                            self.draw_treasure(player: 0)
                        } else if game.closedCards.count == 0{
                            if let final_player = game.players.last {
                                print("End of round, player \(final_player) wins!")
                                self.draw_treasure(player: final_player)
                            } else {
                                print("End of round, you win!")
                                self.draw_treasure(player: 0)
                            }
                        } else {
                            self.turn = 0
                        }
                    }
                } else { // models play without the player
                    draw_vulcano(player: 0)
                    var delay = 0.0
                    while game.closedCards.count > 0 {
                        print(game.players)
                        if game.players.count < 2 {
                            break
                        }
                        delay = 0.0
                        for player in game.players {
                            if game.players.count < 2 {
                                break
                            }
                            delay += 1.5
                            turn = player
                            // Check all unflipped cards, after they are shuffled if there are any
                            model_turn(player: player)
                        }
                    }
                    Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                        let game = self.game
                        print("players: \(game.players)")
                        print("End of round. player \(game.players[0]) wins")
                        self.draw_treasure(player: game.players[0])
                    }
                }
            }
        }
    }
    
    func model_turn(player: Int) {
        if game.closedCards.count > 0 {
            let model = modelArray[player-1]
            game.closedCards.shuffle()
            var answer = ""
            var model_choice = game.closedCards.randomElement()! // random flip in case no match is found
            print("-------- Start checking ------------")
            for card in game.closedCards {
                // cardNr is the number of the unflipped card
                // lastAnimal is the animal from the last flipped card
                // lastBackground is the background of the last flipped card
                print("Currently checking card: \(card)")
                answer = model.checkCard(cardNr: card, lastAnimal: game.lastCard.animal, lastBackground: game.lastCard.background) ?? ""
                //print(answer)
                
                if answer == "animalMatch" || answer == "backgroundMatch" {
                    model_choice = (model.model.lastAction(slot: "cardNr")! as NSString).integerValue
                    print("Answer is: \(model_choice)")
                    print("Card is: \(card)")
                    break
                }
            }
        // For loop through all unflipped cards
        
            flipCard(at: model_choice)
            if !game.matchingCard(card1: game.lastCard, card2: model_choice, player: player) {
               draw_vulcano(player: player)
            }
        } else {
            game.players.remove(at: game.players.firstIndex(of: player)!)
            draw_vulcano(player: player)
        }
    }
    
    func first_round() {
        if turn != 0 {
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                self.model_turn(player: self.turn)
                if self.turn < 3 {
                    self.turn += 1
                } else {
                    self.turn = 0
                }
            
                self.first_round()
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
        UIView.animate(withDuration:1, animations: {self.pileButtons[vulcano].frame.origin.y=CGFloat(y_change);self.pileButtons[vulcano].frame.origin.x=CGFloat(x_change)})
        print("vulc:", self.pileButtons[vulcano].frame.origin)
        if game.vulcanos[vulcano] == 3 {
            game.starter = player
        }
    }
    
    func draw_treasure(player: Int) {
        let treasure = 2 + game.round
        let y_change = self.game.y_changes[player+4]
        let x_change = self.game.x_changes[player+4]
        UIView.animate(withDuration:1, animations: {self.pileButtons[treasure].frame.origin.y=CGFloat(y_change);self.pileButtons[treasure].frame.origin.x=CGFloat(x_change)},
            completion: { _ in
                self.scores[player] += self.game.treasures[self.game.round-1]
                self.nextRound()
                self.turn = self.game.starter
                self.first_round()
            })
    }
    
    func flipCard(at cardNr: Int) {
        
        for player in 0...2 {
            let model = modelArray[player]
            model.memorizeCard(cardNo: cardNr,animal: game.cards[cardNr].animal, background: game.cards[cardNr].background)
        }
        
        //print(cardNr)
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
