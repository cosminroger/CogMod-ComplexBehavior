//
//  memoar.swift
//  memooar
//
//  Created by Mark on 03/02/2021.
//

import Foundation

class Memoar {
    
    var cards = [Card]()
    var turn = 0
    var closedCards = [Int]()
    
    func chooseCard(at index: Int) {
        if cards[index].isFaceUp == false{
            cards[index].isFaceUp = true
            closedCards.remove(at: index)
        }
    }
    
    func resetRound() {
        for index in cards.indices {
            cards[index].isFaceUp = false
        }
    }
    
    init(NrOfCards: Int) {
        var combs = [("seal","1"),("seal","2"),("seal","3"),("seal","4"),("seal","5"), ("crab","1"), ("crab","2"), ("crab","3"), ("crab","4"), ("crab","5"), ("squid","1"), ("squid","2"), ("squid","3"), ("squid","4"), ("squid","5"), ("penguin","1"), ("penguin","2"), ("penguin","3"), ("penguin","4"), ("penguin","5"), ("turtle","1"), ("turtle","2"), ("turtle","3"), ("turtle","4"), ("turtle","5")].shuffled()

        for _ in 0...NrOfCards-2 {
            let comb = combs.removeFirst()
            let card = Card(Background: comb.1, Animal: comb.0)
            cards.append(card)
            closedCards.append(card.identifier)
        }
        let card = Card(Background: "0", Animal: "Volcano")
        cards.append(card)
    }
}
