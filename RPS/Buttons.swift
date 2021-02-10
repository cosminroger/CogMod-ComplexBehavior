//
//  Buttons.swift
//  RPS
//
//  Created by Clemens Kaiser on 10.02.21.
//

import Foundation

struct Choice{
    var isChosen = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init(){
        self.identifier = Choice.getUniqIdentifier()
    }
}
