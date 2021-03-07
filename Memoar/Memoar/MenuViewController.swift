//
//  MenuViewController.swift
//  Memoar
//
//  Created by Mark on 07/03/2021.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var menuButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        for button in self.menuButtons {
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 1
            button.layer.shadowOffset = CGSize(width: 4, height: 7)
            
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 3
            button.layer.borderColor = #colorLiteral(red: 0.6424743068, green: 0.6488066511, blue: 1, alpha: 1)
            
        }

        // Do any additional setup after loading the view.
    }

}
