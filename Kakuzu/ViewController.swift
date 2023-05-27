//
//  ViewController.swift
//  Kakuzu
//
//  Created by Jonathan Socoy and Susannah Abrams on 5/26/23.
//

import UIKit

class ViewController: UIViewController {

    // players
    var player1 = "Player 1"
    var player2 = "Player 2"
    
    // players scores
    var player1_score = 0
    var player2_score = 0
    
    // tile 1 test
    let randomGuess = Int.random(in: 0..<6)
    var firstTile: String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // buttons actions
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        sender.alpha = 0.0
        
        self.displayNumber()
        
        // delay by 0.2 seconds, then cover number if guess incorrect
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            sender.alpha = 1.0
        }
        
//        if randomNumber == numberOnBoard:
//                player1Score += 1
//
//        else:
//                sender.alpha = 1.0
//                nextPlayerTurn
        
        
        
    }
    
    
    
    func displayNumber() -> View {
        Group {
            if randomGuess == 1 {
                VStack {
                        Text(firstTile)
                    }
                }
        }
    }
    

}

