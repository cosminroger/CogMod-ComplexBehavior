//
//  ResultViewController.swift
//  Memoar
//
//  Created by Mark on 29/03/2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    var scores = [0,0,0,0]
    var win = false

    @IBOutlet var resultButtons: [UIButton]!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var highscoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in self.resultButtons {
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 1
            button.layer.shadowOffset = CGSize(width: 4, height: 7)
            
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 3
            button.layer.borderColor = #colorLiteral(red: 0.6424743068, green: 0.6488066511, blue: 1, alpha: 1)
            
        }
        if win {
            resultLabel.text = "Congratulations! You won with \(scores[0]) points"
        } else {
            resultLabel.text = "You lost with \(scores[0]) points"
        }
        var highscoreText = ""
        for i in 0...3 {
            if i != 0 {
                highscoreText += "\n"
            }
            let bestScore = scores.firstIndex(of: scores.max()!)!
            if bestScore == 0 {
                highscoreText += "You: \(scores[0]) points"
            } else {
                highscoreText += "Player\(bestScore): \(scores[bestScore]) points"
            }
            scores[bestScore] = -1
        }
        highscoreLabel.text = highscoreText
        // Do any additional setup after loading the view.
    }

}
