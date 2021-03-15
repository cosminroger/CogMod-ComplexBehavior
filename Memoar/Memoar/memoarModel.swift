//
//  memoarModel.swift
//  Memoar
//
//  Created by Cosmin Roger on 10/03/2021.
//

import Foundation

struct memoarModel {
    let name = "Model"
    let model = Model()
    
    init() {
        model.loadModel(fileName: "memoar")
        model.run()
        print(model.lastAction(slot: "isa"))
    }
    
    func memorizeCard(cardNo: Int!, animal: String!, background: String!) {
        let chunk = Chunk(s: "card\(String(describing: cardNo))", m: model)
        chunk.setSlot(slot: "isa", value: "memorize")
        chunk.setSlot(slot: "cardNr", value: "card\(String(cardNo))")
        chunk.setSlot(slot: "animal", value: animal)
        chunk.setSlot(slot: "background", value: background)
        model.buffers["visual"] = chunk
        
        model.run()
        //print(model.lastAction(slot: "isa"))
        print(model.dm.chunks)
    }
    
    func checkCard(cardNr: Int!, lastAnimal: String!, lastBackground: String!) -> String? {
        let chunk = Chunk(s: "card\(String(describing: cardNr))", m: model)
        chunk.setSlot(slot: "isa", value: "myTurn")
        chunk.setSlot(slot: "cardNr", value: "card\(String(cardNr))")
        chunk.setSlot(slot: "lastAnimal", value: lastAnimal)
        chunk.setSlot(slot: "lastBackground", value: lastBackground)
        model.buffers["visual"] = chunk
        
        model.run()
        return model.lastAction(slot: "isa")
    }
}

