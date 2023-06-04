//
//  ViewController.swift
//  Kakuzu
//
//  Created by Jonathan Socoy and Susannah Abrams on 5/26/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    var board = [[0,0,0,0,0,0,0,0,0],
             [0,0,0,0,0,0,0,0,0],
             [0,0,0,0,0,0,0,0,0],
             [0,0,0,0,0,0,0,0,0],
             [0,0,0,0,0,0,0,0,0],
             [0,0,0,0,0,0,0,0,0],
             [0,0,0,0,0,0,0,0,0],
             [0,0,0,0,0,0,0,0,0],
             [0,0,0,0,0,0,0,0,0]]
    
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
        print(board)
        populateBoard()
        print(board)
        //fillBoard()
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
        //sender.setTitle(firstTile, for: UIControl.State.normal)
        
        // select a random number that the user needs to guess correct square
        //https://stackoverflow.com/questions/24007129/how-to-generate-a-random-number-in-swift
        // TODO: implement a separate method and button to display number
        randomGuess = Int.random(in: 0..<9)
        
        // if user guessed correctly, remove cover and display number
        // TODO: add points to each player who guesses correctly
        if randomGuess == 0 {
            sender.backgroundColor = UIColor.white
        } else {
            // delay by 1 second, then cover number if guess incorrect
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                sender.backgroundColor = UIColor.black
                //sender.setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
    func fillBoard() {
        
        var list = 0
        var index = 0
    
        for layer1 in view.subviews {
            for layer2 in layer1.subviews {
                for element in layer2.subviews {
                    if element is UIButton {
                        let button = element as! UIButton
                        let val = board[list][index]
                        button.setTitle(String(val), for: UIControl.State.normal)
                    }
                    index = index + 1
                }
                index = 0
                list = list + 1
            }
        }
         
    }
    
    func in_square(x : Int, y : Int, val : Int) -> Bool {
        
        let r = Int(3 * floor(Float(x) / 3))
        let c = Int(3 * floor(Float(y) / 3))
        
        for i in 1...3 {
            for j in 1...3 {
                if (board[r+i][c+j] == val){
                    return true
                }
            }
        }
        
        return false
        
    }
    
    func populateBoard() {
        
        var count = 0
        var r = 0
        
        while (r < 9) {
            print(r)
            var numbers = [1,2,3,4,5,6,7,8,9]
            var c = 0
            
            while (c < 9) {
                
                if (count >= 20) {
                    board[r] = [0,0,0,0,0,0,0,0,0]
                    r = r - 1
                    count = 0
                    continue
                }
                count = 0
                
                
                while (count < 20) {
                    
                    let val = numbers.randomElement()!
                    let col = [board[0][c],board[1][c],board[2][c],
                               board[3][c],board[4][c],board[5][c],
                               board[6][c],board[7][c],board[8][c]]
                    
                    let in_col = col.contains(val)
                    if (!in_col && !in_square(x:r, y:c, val:val)){
                        board[r][c] = val
                        let index = numbers.firstIndex(of: val)
                        numbers.remove(at: index!)
                        break
                        
                        
                    }
                    count = count + 1
            
                }
                c = c + 1
            }
            r = r + 1
            
        }
    }
    
}

