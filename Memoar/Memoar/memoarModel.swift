//
//  memoarModel.swift
//  Memoar
//
//  Created by Cosmin Roger on 10/03/2021.
//

import Foundation

class memoarModel {
    let name = "Model"
    let model = Model()
    var time = NSDate().timeIntervalSince1970 * 1000
    
    init() {
        model.loadModel(fileName: "memoar")
        model.run()
        time = NSDate().timeIntervalSince1970 * 1000
    }
    
    func memorizeCard(cardNo: Int!, animal: String!, background: String!) {
        let chunk = Chunk(s: "card\(String(describing: cardNo))", m: model)
        chunk.setSlot(slot: "isa", value: "memorize")
        chunk.setSlot(slot: "cardNr", value: "\(String(cardNo))")
        chunk.setSlot(slot: "animal", value: animal)
        chunk.setSlot(slot: "background", value: background)
        model.buffers["visual"] = chunk
        
        model.time += ((NSDate().timeIntervalSince1970 * 1000 - time)/1000)
        time = NSDate().timeIntervalSince1970 * 1000
        
        model.run()
        //print(model.dm.chunks)
    }
    
    func checkCard(cardNr: Int!, lastAnimal: String!, lastBackground: String!) -> String? {
        let chunk = Chunk(s: "card\(String(describing: cardNr))", m: model)
        chunk.setSlot(slot: "isa", value: "myTurn")
        chunk.setSlot(slot: "cardNr", value: "\(String(cardNr))")
        chunk.setSlot(slot: "lastAnimal", value: lastAnimal)
        chunk.setSlot(slot: "lastBackground", value: lastBackground)
        model.buffers["visual"] = chunk
        
        model.time += ((NSDate().timeIntervalSince1970 * 1000 - time)/1000)
        time = NSDate().timeIntervalSince1970 * 1000
        
        model.run()
        return model.lastAction(slot: "isa")

    }
}

