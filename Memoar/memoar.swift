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
        print(cards[index].animal, cards[index].background)
    }
    
    init(NrOfCards: Int) {
        let animals = ["Seal", "Penguin", "Squid", "Crab", "Turtle", "Seal", "Penguin", "Squid", "Crab", "Turtle", "Seal", "Penguin", "Squid", "Crab", "Turtle", "Seal", "Penguin", "Squid", "Crab", "Turtle", "Seal", "Penguin", "Squid", "Crab", "Turtle"].shuffled()
        let backgrounds = ["Blue", "Purple", "Yellow", "Green", "Red","Blue", "Purple", "Yellow", "Green", "Red","Blue", "Purple", "Yellow", "Green", "Red","Blue", "Purple", "Yellow", "Green", "Red","Blue", "Purple", "Yellow", "Green", "Red"].shuffled()
        for identifier in 0...NrOfCards-2 {
            let card = Card(Background: backgrounds[identifier], Animal: animals[identifier])
            cards.append(card)
        }
        let card = Card(Background: "Volcano", Animal: "3")
        cards.append(card)
        //TODO: Shuffle cards
    }
}
