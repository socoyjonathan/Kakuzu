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
    //https://stackoverflow.com/questions/38534573/changing-opacity-of-button-when-clicked-xcode-swift
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        // set background color to white
        //https://stackoverflow.com/questions/24427284/change-button-background-color-using-swift-language
        sender.backgroundColor = UIColor.white
        
        // dynamically set the button text to the number in the array at that position
        //https://stackoverflow.com/questions/26326296/changing-text-of-uibutton-programmatically-swift
        sender.setTitle(firstTile, for: UIControl.State.normal)
        
        // select a random number that the user needs to guess correct square
        //https://stackoverflow.com/questions/24007129/how-to-generate-a-random-number-in-swift
        // TODO: implement a separate method and button to display number
        randomGuess = Int.random(in: 0..<9)
        
        // if user guessed correctly, remove cover and display number
        // TODO: add points to each player who guesses correctly
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

