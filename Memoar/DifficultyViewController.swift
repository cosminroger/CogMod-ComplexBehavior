//
//  DifficultyViewController.swift
//  Memoar
//
//  Created by Mark on 01/04/2021.
//

import UIKit

class DifficultyViewController: UIViewController {
    
    @IBAction func touchButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "difficultySegue", sender: sender)
    }
    @IBOutlet var difficultyButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        for button in self.difficultyButtons {
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 1
            button.layer.shadowOffset = CGSize(width: 4, height: 7)
            
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 3
            button.layer.borderColor = #colorLiteral(red: 0.6424743068, green: 0.6488066511, blue: 1, alpha: 1)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let difficulty = difficultyButtons.firstIndex(of: sender as! UIButton)!
        let vc = segue.destination as! ViewController
        vc.difficulty = difficulty
    }
}
