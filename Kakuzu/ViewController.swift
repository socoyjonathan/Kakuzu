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
    
    var num = 0
    
    var turn = 0
    
    // players
    var player1 = "Player 1"
    var player2 = "Player 2"
    
    // players scores
    var player1_score = 0
    var player2_score = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBoard()
        // Do any additional setup after loading the view.
    }

    
    func resetBoard() {
        
        board = [[0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0]]
        
        populateBoard()
        fillBoard()
    }
    
    
    @IBAction func resetClicked(_ sender: UIButton) {
        
        //cover all tiles
        
        resetBoard()
        
    }
    
    @IBAction func newNumberClicked(_ sender: UIButton) {
        
        
        num = Int.random(in: 1..<10)
        
        //show this to the user
        
    }
    
    // buttons actions
    //https://stackoverflow.com/questions/38534573/changing-opacity-of-button-when-clicked-xcode-swift
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        sender.backgroundColor = UIColor.white
   
        
        //check if guess was correct
        if Int(String(sender.currentTitle!)) == num {
            sender.backgroundColor = UIColor.white
            
            //check to see if that number is done
        }
        
        //if not correct, cover tile and change turns
        else {
            // delay by 1 second, then cover number if guess incorrect
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                sender.backgroundColor = UIColor.black
                //sender.setTitle("", for: UIControl.State.normal)
                self.turn = (self.turn + 1) % 2
                
                //show turn change to user
            }
        }
    }

    
    //fill the buttons with the values from the "board" global variable
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
                        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
                        button.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
                    }
                    index = index + 1
                }
                index = 0
                list = list + 1
            }
        }
         
    }
    
    //helper function for populateBoard
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
    
    //generate a new sudoku board in the "board" global variable
    func populateBoard() {
        
        var count = 0
        var count2 = 0
        var r = 0
        
        var redo = false
        
        while (r < 9) {
            //print("row: " + String(r))
            
            var numbers = [1,2,3,4,5,6,7,8,9]
            var c = 0
            
            if (redo){
                redo = false
            }
            
            if (count2 >= 20) {
                print("count2 >= 20")
                return
            }
            
            
            while (!redo && c < 9) {
               // print("col: " + String(c))
                
                

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
                        //print("value: " + String(val))
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
                //print(board[r])
            }
            r = r + 1
            
        }
    }
    
}

