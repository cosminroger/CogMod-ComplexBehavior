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
    init(){
        for _ in 1...3 {
            let choice = Choice()
            choices.append(choice)
        }
    }
}




