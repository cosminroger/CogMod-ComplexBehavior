//
//  memoar.swift
//  memooar
//
//  Created by Mark on 03/02/2021.
//

import Foundation

class Memoar {
    
    var cards = [Card]()
    var closedCards = [Int]()
    var failed_players = 0
    var lastCard = Card(Background: "", Animal: "")
    var players = [1,2,3]
    var round = 1
    var starter = 0
    var treasures = [1,1,2,2,2,3,4]
    var vulcanos = [1,2,3]
    var x_changes = [641,257,457,841,733,257,365,841]
    var y_changes = [669,465,69,273,669,561,69,177]
    
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
