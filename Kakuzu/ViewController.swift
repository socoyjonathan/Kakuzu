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
    var randomGuess = 0
    var firstTile: String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // buttons actions
    @IBAction func buttonClicked(_ sender: UIButton) {
        // set background color to white
        sender.backgroundColor = UIColor.white
        // dynamically set the button text to the number in the array at that position
        sender.setTitle(firstTile, for: UIControl.State.normal)
        
        // select a random number that the user needs to guess correct square
        // TODO: implement a separate method and button to display number
        randomGuess = Int.random(in: 0..<9)
        
        // if user guessed correctly, remove cover and display number
        // TODO: add points to the player who guessed correctly
        if randomGuess == 1 {
            sender.backgroundColor = UIColor.white
        } else {
            // delay by 1 second, then cover number if guess incorrect
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                sender.backgroundColor = UIColor.black
                sender.setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
}

