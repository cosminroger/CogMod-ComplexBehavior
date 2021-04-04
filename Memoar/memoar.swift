//
//  memoar.swift
//  memooar
//
//  Created by Mark on 03/02/2021.
//

import Foundation

class Memoar {
    
    let adjacentCards: [Int:Set<Int>] = [1: [0,2,6],
                         2: [1,3,7],
                         3: [2,4,8],
                         5: [0,6,10],
                         6: [1,5,7,11],
                         7: [2,6,8],
                         8: [3,7,9,12],
                         9: [4,8,13],
                         10: [5,11,14],
                         11: [6,10,15],
                         12: [8,13,17],
                         13: [9,12,18],
                         14: [10,15,19],
                         15: [11,14,16,20],
                         16: [15,17,21],
                         17: [12,16,18,22],
                         18: [13,17,23],
                         20: [15,19,21],
                         21: [16,20,22],
                         22: [17,21,23]]
    var cards = [Card]()
    var closedCards = [Int]()
    var failed_players = 0
    var lastCard = Card(Background: "", Animal: "")
    var players = [1,2,3]
    var round = 1
    var starter = 0
    var treasures = [1,1,2,2,2,3,4]
    var vulcanos = [1,2,3]
    var x_changes = [733,341,549,943,825,341,457,943]
    var y_changes = [771,567,171,375,771, 663,171,279]
    
    func chooseCard(at index: Int) {
        print(index)
        print(closedCards)
        if cards[index].isFaceUp == false{
            cards[index].isFaceUp = true
            let position = closedCards.firstIndex(of: index)!
            closedCards.remove(at: position)
            print(lastCard)
        }
    }
    
    func resetRound() {
        players = [1,2,3]
        failed_players = 0
        closedCards.removeAll()
        lastCard = Card(Background: "", Animal: "")
        vulcanos.shuffle()
        round += 1
        for index in 0...23 {
            closedCards.append(index)
            cards[index].isFaceUp = false
        }
    }
    
    func matchingCard(card1: Card, card2: Int, player: Int) -> Bool {
        lastCard = cards[card2]
        if card1.animal == lastCard.animal || card1.background == lastCard.background || card1.animal == "" {
            //print("yay:\(lastCard) is a match!")
            return true
        }
        if player > 0 {
            players.remove(at: players.firstIndex(of: player)!)
        }
        print("players: \(players)")
        return false
    }
    
    init() {
        var combs = [("seal","1"),("seal","2"),("seal","3"),("seal","4"),("seal","5"), ("crab","1"), ("crab","2"), ("crab","3"), ("crab","4"), ("crab","5"), ("squid","1"), ("squid","2"), ("squid","3"), ("squid","4"), ("squid","5"), ("penguin","1"), ("penguin","2"), ("penguin","3"), ("penguin","4"), ("penguin","5"), ("turtle","1"), ("turtle","2"), ("turtle","3"), ("turtle","4"), ("turtle","5")].shuffled()

        for pos in 0...23 {
            let comb = combs.removeFirst()
            let card = Card(Background: comb.1, Animal: comb.0)
            cards.append(card)
            closedCards.append(pos)
        }
        
        vulcanos.shuffle()
    }
}
