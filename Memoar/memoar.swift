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
    
    init(NrOfPairs: Int) {
        for _ in 1...NrOfPairs {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        //TODO: Shuffle cards
    }
}
