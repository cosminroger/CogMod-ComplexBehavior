//
//  memoar.swift
//  memooar
//
//  Created by Mark on 03/02/2021.
//

import Foundation

class Memoar {
    
    var cards = [Card]()
    
    func chooseCard(at index: Int) {
        if cards[index].isFaceUp{
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }
    
    init(NrOfCards: Int) {
        for _ in 1...NrOfCards {
            let card = Card()
            cards.append(card)
        }
        //TODO: Shuffle cards
    }
}
