//
//  ViewController.swift
//  RPS
//
//  Created by Mark on 10/02/2021.
//

import UIKit

class ViewController: UIViewController {

    var game: RPS = RPS()
    
    
    @IBOutlet var choiceButtons: [UIButton]!
    
            
    @IBAction func makeChoice(_ sender: UIButton) {
        let choiceOption = choiceButtons.firstIndex(of: sender)!
        let modelOption = 0
        game.chooseOption(at: choiceOption)
        game.compareChoices(with: choiceOption, and: modelOption)
        game.resetGame()
        updateView()
    }
    
    func updateView() {
        for index in choiceButtons.indices {
            let button = choiceButtons[index]
            let choice = game.choices[index]
            if choice.isChosen {
                button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            } else {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
}
