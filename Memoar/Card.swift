//
//  Card.swift
//  memory
//
//  Created by Mark on 03/02/2021.
//

import Foundation

struct Card {
    var isFaceUp = false
    var background: String
    var animal: String
    
    init(Background: String, Animal: String) {
        self.background = Background
        self.animal = Animal
    }
}
