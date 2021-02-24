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
    var identifier: Int
    
    static var identifierFactory = -1
    static func getUniqIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init(Background: String, Animal: String) {
        self.identifier = Card.getUniqIdentifier()
        self.background = Background
        self.animal = Animal
    }
}
