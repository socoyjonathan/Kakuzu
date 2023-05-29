

import numpy as np
import random

numbers = [1,2,3,4,5,6,7,8,9]



def in_square(board, x, y, val):
    #find the square the point is in
    r = (int)(3*np.floor(x/3))
    c = (int)(3*np.floor(y/3))

    for i in range(3):
        for j in range(3):
            if (board[r+i,c+j] == val):
                return 1


    return 0

def populate_board(board):
    count = 0 
    r = 0

    while(r < 9):
        n = [1,2,3,4,5,6,7,8,9]
        c = 0

        while (c < 9):
            if (count >= 20):
                board[r,:] = np.zeros(9)
                r = r -1
                count = 0
                continue
            count = 0
            
            #infinite loop to find a new random number to add
            while(count < 20):
                count= count +1

                val = random.choice(n)

                #if the value is not already in the square, row or column
                in_col = val in board[:, c]
                if(not in_col and not in_square(board, r, c, val)):
                    board[r,c] = val
                    n.remove(val)
                    break
            c = c +1
        r = r +1
    return 1


if __name__ == "__main__":


    board = np.zeros((9,9))
    populate_board(board)
    print(board)
   # while(1):
       # print("new board")
       # board = np.zeros((9,9))
        #if(populate_board(board)):
        #    print("done")
    

 
