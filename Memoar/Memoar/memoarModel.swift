//
//  memoarModel.swift
//  Memoar
//
//  Created by Cosmin Roger on 10/03/2021.
//

import Foundation

struct memoarModel {
    let model = Model()
    
    init() {
        model.loadModel(fileName: "memoar")
        model.run()
        print(model.lastAction(slot: "isa"))
    }
}
