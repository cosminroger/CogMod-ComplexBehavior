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
        let choiceOption = choiceButtons.firstIndex(of: sender)
        RPS.chooseOption(at: choiceOption)
    }
    
    func updateView() {
        for index in choiceButtons.indices {
            let button = choiceButtons[index]
            let choice = RPS
            if choice.isChosen {
            
            }
        }
    }
}
