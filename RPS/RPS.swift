//
//  RPS.swift
//  RPS
//
//  Created by Clemens Kaiser on 10.02.21.
//

import Foundation

class RPS {
    var choices = [Choice]()
    
    func chooseOption(at index: Int){
        choices[index].isChosen = true
    
    }
    
    func compareChoices(with playerChoice: Int, and modelChoice: Int) -> Int{
        if playerChoice == modelChoice {
            return 0
        } else if playerChoice == modelChoice-1 || (playerChoice == 2 && modelChoice == 0) {
            return 1
        } else {
            return 2
        }

    }
    
    func resetGame(){
        for index in choices.indices {
            choices[index].isChosen = false
        }
    }
    
    init(){
        for _ in 1...3 {
            let choice = Choice()
            choices.append(choice)
        }
    }
}




