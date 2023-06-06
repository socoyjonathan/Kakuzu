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
    var board = [[0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0]]
    
    
    // player labels and buttons
    @IBOutlet weak var player1: UILabel!
    @IBOutlet weak var newNumber: UIButton!
    @IBOutlet weak var player2: UILabel!
    @IBOutlet weak var newNumLabel: UILabel!
    

    // players scores
    var player1_score = 0
    var player2_score = 0
    
    var num = 0
    var turn = 0
    
    var nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBoard()
    }
    
    func resetBoard(){
        
        print(board)
        while(!populateBoard()){}
        
        player1_score = 0
        player2_score = 0
        
        player1.text = String(player1_score)
        player2.text = String(player2_score)

        fillBoard()
        print(board)
        
        
    }
    
    
    @IBAction func resetBoardClick(_ sender: UIButton) {
        
        board = [[0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0]]

        player1_score = 0
        player2_score = 0
        
        player1.text = String(player1_score)
        player2.text = String(player2_score)
//        player1.font = UIFont.boldSystemFont(ofSize: 20.0)
//        player2.font = UIFont.boldSystemFont(ofSize: 20.0)

        fillBoard()
        resetBoard()
        
        
        
        nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        newNumLabel.text = ""
        
    }
    
    

    
    @IBAction func newNumber(_ sender: UIButton) {
        num = Int.random(in: 1..<10)
        newNumLabel.text = String(num)
        newNumLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        sender.isEnabled = false
        
    }


    // button actions
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        sender.backgroundColor = UIColor.white
        
        if (Int(String(sender.currentTitle!)) == num) {
            sender.backgroundColor = UIColor.white
            
            if turn == 0 {
                player1_score += 1
            } else {
                player2_score += 1
            }
            
            player1.text = String(player1_score)
            player2.text = String(player2_score)
            player1.font = UIFont.boldSystemFont(ofSize: 20.0)
            player2.font = UIFont.boldSystemFont(ofSize: 20.0)
            
        } else {
            // delay by 1 second, then cover number if guess incorrect
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                sender.backgroundColor = UIColor.black
                
                self.newNumber.isEnabled = true
                self.turn = (self.turn + 1) % 2
                
                if (self.turn == 0){
                    self.player1.backgroundColor = UIColor.red
                    self.player2.backgroundColor = UIColor.white
                } else {
                    self.player2.backgroundColor = UIColor.blue
                    self.player1.backgroundColor = UIColor.white
                }
        
                // show turn to user
                
                
            }
        }
    }

    
    //return an array of 9 tuples to uncover
    func pickUncover() -> Array<Array<Int>>{
        
        return [[1,2],[8,7]]
    }
    
    
    
    
    func fillBoard(){
        
        let uncover = pickUncover()
        
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
                        let coordinate = [row, index]
                        if (uncover.contains(coordinate)) {
                            button.backgroundColor = UIColor.white
                        }
                        let val = board[row][index]
                        button.setTitle(String(val), for: UIControl.State.normal)
                        button.setTitleColor(UIColor.black, for: .normal)
                        button.setTitleColor(UIColor.black, for: .selected)
                    }
                    index = index + 1
                }
                index = 0
                row = row + 1
            }
        }
        
    }
    
    func in_square(x : Int, y : Int, val : Int) -> Bool {
        
        let r = Int(3 * floor(Float(x) / 3))
        let c = Int(3 * floor(Float(y) / 3))
        
        for i in 0...2 {
            for j in 0...2 {
                if (board[r+i][c+j] == val){
                    return true
                }
            }
        }
        
        return false
        
    }


    
    func populateBoard() -> Bool {
        
        var count = 0
        var count2 = 0
        var r = 0
        
        var redo = false
        
        while (r < 9) {
            
            var numbers = [1,2,3,4,5,6,7,8,9]
            var c = 0
            
            if (redo){
                redo = false
            }
            
            if (count2 >= 20) {
                print("count2 >= 20")
                return false
            }
            
            
            while (!redo && c < 9) {

                while (!redo && count < 20) {

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
                
                if (count >= 20) {
                    count2 = count2 + 1
                    board[r] = [0,0,0,0,0,0,0,0,0]
                    r = r - 1
                    count = 0
                    redo = true
                    break
                }
                
                count = 0
                c = c + 1
            }
            
            r = r + 1
        }
        
        return true
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

