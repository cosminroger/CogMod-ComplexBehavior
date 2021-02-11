//
//  ViewController.swift
//  RPS
//
//  Created by Mark on 10/02/2021.
//

import UIKit

class ViewController: UIViewController {

    var game: RPS = RPS()
    
    var playerScore = 0 {
        didSet{
            playerScoreLabel.text = "\(playerScore)"
        }
    }
    
    var modelScore = 0 {
        didSet{
            modelScoreLabel.text = "\(modelScore)"
        }
    }
    
    var winner = "" {
        didSet{
            winnerLabel.text = "\(winner)"
        }
    }
    
    @IBOutlet var playerScoreLabel: UILabel!
    
    @IBOutlet var modelScoreLabel: UILabel!
    
    @IBOutlet var choiceButtons: [UIButton]!
    
    @IBOutlet var winnerLabel: UILabel!
    
    @IBAction func makeChoice(_ sender: UIButton) {
        let choiceOption = choiceButtons.firstIndex(of: sender)!
        let modelOption = 0
        game.chooseOption(at: choiceOption)
        
        let result = game.compareChoices(with: choiceOption, and: modelOption)
        if result == 1 {
            modelScore += 1
            winner = "You lose!"
            
        } else if result == 2 {
            playerScore += 1
            winner = "You win!"
        } else{
            winner = "Draw!"
        }
        game.resetGame()
        updateView()
    }
    
    func updateView() {
        for index in choiceButtons.indices {
            let button = choiceButtons[index]
            let choice = game.choices[index]
        }
    }
    
    
    
}
