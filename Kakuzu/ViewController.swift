//
//  ViewController.swift
//  Kakuzu
//
//  Created by Jonathan Socoy and Susannah Abrams on 5/26/23.
//
// https://www.youtube.com/watch?v=VE3oYpXJ-mo

import UIKit
import Swift
import Foundation

class ViewController: UIViewController {
    
    // let creates immutable variables (constants)
    // var creates mutable variables
    var board = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                 [1, 2, 3, 4, 5, 6, 7, 8, 9, 1],
                 [2, 3, 4, 5, 6, 7, 8, 9, 0, 1],
                 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                 [1, 2, 3, 4, 5, 6, 7, 8, 9, 1],
                 [2, 3, 4, 5, 6, 7, 8, 9, 0, 1],
                 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                 [1, 2, 3, 4, 5, 6, 7, 8, 9, 1],
                 [2, 3, 4, 5, 6, 7, 8, 9, 0, 1]]
    
    // players
    var player1 = "Player 1"
    var player2 = "Player 2"
    
    // players scores
    var player1_score = 0
    var player2_score = 0
    
    // tile 1 test
    var randomGuess = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillBoard()
        randomGuess = Int.random(in: 0..<9)
        
        // Do any additional setup after loading the view.
    }

    
    // buttons actions
    //https://stackoverflow.com/questions/38534573/changing-opacity-of-button-when-clicked-xcode-swift
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        // set background color to white
        //https://stackoverflow.com/questions/24427284/change-button-background-color-using-swift-language
        sender.backgroundColor = UIColor.white
        
        // select a random number that the user needs to guess correct square
        //https://stackoverflow.com/questions/24007129/how-to-generate-a-random-number-in-swift
        // TODO: implement a separate method and button to display number
        
        
        // if user guessed correctly, remove cover and display number
        // TODO: add points to each player who guesses correctly
        // https://developer.apple.com/documentation/uikit/uibutton/1624032-currenttitle
        if (Int(String(sender.currentTitle!)) == randomGuess) {
            sender.backgroundColor = UIColor.white
        } else {
            // delay by 1 second, then cover number if guess incorrect
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                sender.backgroundColor = UIColor.black
            }
        }
    }

    
    
    func fillBoard(){
        
        var row = 0
        var index = 0
        
        // https://stackoverflow.com/questions/42629306/looping-through-uibuttons-in-uiview
        // https://stackoverflow.com/questions/43493830/how-can-i-get-all-buttons-from-a-view
        for layer1 in view.subviews{
            for layer2 in layer1.subviews {
                for element in layer2.subviews{
                    if element is UIButton {
                        let button = element as! UIButton
                        button.backgroundColor = UIColor.black
                        let val = board[row][index]
                        button.setTitle(String(val), for: UIControl.State.normal)
                        // https://stackoverflow.com/questions/31088172/how-to-set-the-title-text-color-of-uibutton
                        button.setTitleColor(UIColor.black, for: .normal)
                        
                    }
                    index = index + 1
                }
                index = 0
                row = row + 1
            }
        }
        
    }
    
    
    
    
    func in_square(x : Int, y : Int, val : Int) -> Int {
        
        let r = Int(3 * floor(Float(x) / 3))
        let c = Int(3 * floor(Float(y) / 3))
        
        for i in 1...3 {
            for j in 1...3 {
                if (board[r+i][c+j] == val){
                    return 1
                }
            }
        }
        
        return 0
        
    }
    
//    func populate_board(){
//
//       //  let n = [1, 2, 3, 4, 5, 6, 7, 8, 9]
//        var count = 0
//        var r = 0
//        var c = 0
//
//        // https://developer.apple.com/documentation/swift/int/random(in:)-9mjpw
//        var val = Int.random(in: 1..<10)
//
//        in_square(r: Int, c, val)
//
//    }

    
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
                    if (!in_col){
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
    
    
    
    /*
    makeBoard():
    setTitle(eachTile):
    
    // dynamically set the button text to the number in the array at that position
    //https://stackoverflow.com/questions/26326296/changing-text-of-uibutton-programmatically-swift
    sender.setTitle(firstTile, for: UIControl.State.normal)
    */
    
    // represent a multidimensional array in swift
    // iterate through all onjects (buttons) in a View
    
}

