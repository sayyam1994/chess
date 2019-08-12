class Piece

    attr_accessor :name, :colour
    

    def initialize(name,colour = nil)
        @name = name
        @colour = colour
        @empty_block = "\u26F6 "
    end

    def remove_out_of_board_moves(moves, board)
        valid_moves = []
        moves.each_with_index do |move, index|
            if move[0] >= 0 && move[0] <= 7 && move[1] >= 0 && move[1] <= 7
                valid_moves << move
            end
        end
        valid_moves
    end

    def check_path_availability(row, col, board, player_colour)
        if board[row][col].name != @empty_block
            if board[row][col].colour != player_colour
                return false
            else
                return true
            end
        end
    end

end

class Pawn < Piece

    def possible_moves(row, col, board, player_colour)

        moves = []

        if board[row][col].colour == "White"
            if row == 6
                moves << [row - 1,col] if board[row - 1][col].colour != "Black"
                moves << [row - 2,col] if board[row - 1][col].colour != "Black" && board[row - 2][col].colour != "Black"
            else
                moves << [row - 1,col] if board[row - 1][col].colour != "Black"
            end

            if col < 7 && row > 0
                if board[row - 1][col + 1].colour == "Black" 
                moves << [row - 1,col + 1]
                end
            end

            if row > 0
                if board[row - 1][col - 1].colour == "Black" 
                    moves << [row - 1,col - 1]
                end
            end

        elsif board[row][col].colour == "Black"
            if row == 1
                moves << [row + 1,col] if board[row + 1][col].colour != "White"
                moves << [row + 2,col] if board[row + 1][col].colour != "White" && board[row + 2][col].colour != "White"
            else
                moves << [row + 1,col] if board[row + 1][col].colour != "White"
            end

            if col < 7 && row < 7
                if board[row + 1][col + 1].colour == "White" 
                    moves << [row + 1,col + 1]
                end
            end

            if row < 7
                if board[row + 1][col - 1].colour == "White" 
                    moves << [row + 1,col - 1]
                end
            end
        end 

        moves = remove_out_of_board_moves(moves, board)
    end
    
end

class Knight < Piece

    def possible_moves(row, col, board, player_colour)
        
        moves = [[row + 2, col + 1], [row + 1, col + 2], [row - 1, col + 2], [row - 2, col + 1],
        [row - 2, col - 1], [row - 1, col - 2], [row + 1, col - 2], [row + 2, col - 1]]

        moves = remove_out_of_board_moves(moves, board)

    end
    
end

class King < Piece

    def possible_moves(row, col, board, player_colour)
        
        moves = [[row + 1, col - 1], [row + 1, col], [row + 1, col + 1], [row, col + 1],
        [row - 1, col + 1], [row - 1, col], [row, col - 1], [row - 1, col - 1]]

        moves = remove_out_of_board_moves(moves, board)

    end
    
end

class Rook < Piece

    def possible_moves(row, col, board, player_colour)
        r = row
        c = col
        moves = []

        #vertically Up
        until r >= 7
            r += 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
        
        #vertically Down
        r = row
        c = col
        until r <= 0
            r -= 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
        
        #horizontally left
        r = row
        c = col
        until c <= 0
            c -= 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end

        #horizontally right
        r = row
        c = col
        until c >= 7
            c += 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
        moves = remove_out_of_board_moves(moves, board)
    end
end

class Bishop < Piece

    def possible_moves(row, col, board, player_colour)
        r = row
        c = col
        moves = []
        
        #south east
        until r >= 7 || c >= 7
            r += 1
            c += 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
            
        #south west
        r = row
        c = col
        until r >= 7 || c <= 0
            r += 1
            c -= 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
            
        #north east
        r = row
        c = col
        until r <= 0 || c >= 7
            r -= 1
            c += 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
    
        #north west
        r = row
        c = col
        until c <= 0 || r <= 0
            r -= 1
            c -= 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
        moves = remove_out_of_board_moves(moves, board)
    end
end
    

class Queen < Piece

    def possible_moves(row, col, board, player_colour)
        r = row
        c = col
        moves = []
    
        #vertically Up
        until r >= 7
            r += 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
        
        #vertically Down
        r = row
        c = col
        until r <= 0
            r -= 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
        
        #horizontally left
        r = row
        c = col
        until c <= 0
            c -= 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end

        #horizontally right
        r = row
        c = col
        until c >= 7
            c += 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
        
        r = row
        c = col

        #south east
        until r >= 7 || c >= 7
            r += 1
            c += 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
            
        #south west
        r = row
        c = col
        until r >= 7 || c <= 0
            r += 1
            c -= 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
            
        #north east
        r = row
        c = col
        until r <= 0 || c >= 7
            r -= 1
            c += 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
    
        #north west
        r = row
        c = col
        until c <= 0 || r <= 0
            r -= 1
            c -= 1
            if check_path_availability(r, c, board, player_colour) == true
                break
            elsif check_path_availability(r, c, board, player_colour) == false
                moves << [r,c]
                break
            end
            moves << [r,c]
        end
        moves = remove_out_of_board_moves(moves, board)
    end
end