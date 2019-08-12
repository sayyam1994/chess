require_relative "piece"
require_relative "board"


class Game

    def initialize
        @chess_board = Board.new
        @player_turn = Board::W
        @chess_board.draw_board
        @empty_block = "\u26F6 "
        @white_taken = []
        @black_taken = []
        get_player_input
    end

    def get_piece_coordinates
        puts "#{@player_turn} select the piece to be moved"
        @coordinate = gets.chomp.upcase.strip
    end

    def get_destination_coordinates
        puts "#{@player_turn} Enter the new location of the piece"
        @coordinate_new = gets.chomp.upcase.strip
    end

    def check_player_coordinates(coordinates)
        if coordinates =~ /\A[a-h][1-8]\z/i
            return true
        else
            return false
        end
    end

    def get_player_input
        loop do
            get_piece_coordinates
            break if check_player_coordinates(@coordinate)
            puts "Please enter valid coordinates"
        end

        loop do
            get_destination_coordinates
            break if check_player_coordinates(@coordinate_new)
            puts "Please enter valid coordinates"
        end
        separate_coordinates
    end

    def separate_coordinates
        piece = @coordinate[0..1]
        row = row_input(piece[1])
        col = column_input(piece[0])

        location = @coordinate_new[0..1]
        row_new = row_input(location[1])
        col_new = column_input(location[0])
        
        turn(row, col, row_new, col_new)
    end

    def turn(row, col, row_new, col_new) 
        if check_current_player(row, col, row_new, col_new)
            make_move(row, col, row_new, col_new)
        end
        next_turn
    end

    def next_turn
        if @player_turn == "White"
            @player_turn = Board::B
        elsif @player_turn == "Black"
            @player_turn = Board::W
        end
        get_player_input
    end

    def check_current_player(row, col, row_new, col_new)
        if @chess_board.board[row][col].colour == @player_turn
            return true
        else
            puts "#{@player_turn}, Please move only your piece"
            get_player_input
        end  
    end

    def make_move(row, col, row_new, col_new)

        print @chess_board.board[row][col].possible_moves(row, col, @chess_board.board, @player_turn)
        puts ""

        if @chess_board.board[row][col].possible_moves(row, col, @chess_board.board, @player_turn).include?([row_new, col_new])
            if @chess_board.board[row_new][col_new].name == @empty_block
                temp = @chess_board.board[row][col]
                @chess_board.board[row][col] = Piece.new(@empty_block)
                @chess_board.board[row_new][col_new] = temp
                @chess_board.draw_board
                display_taken_pieces
            elsif @chess_board.board[row_new][col_new].colour == @chess_board.board[row][col].colour
                puts "OOPS!! the placed is occupied. Please choose different place"
                get_player_input
            else
                piece_taken(row, col, row_new, col_new)
            end
        else
            puts "Please enter a valid move for #{@chess_board.board[row][col].class.to_s}"
            get_player_input
        end
    end

    def row_input(row)
        row = row.to_i - 1
    end

    def column_input(col)
        case col
        when 'A'
          0
        when 'B'
          1
        when 'C'
          2
        when 'D'
          3
        when 'E'
          4
        when 'F'
          5
        when 'G'
          6
        when 'H'
          7
        end
    end

    def piece_taken(row, col, row_new, col_new)
        temp = @chess_board.board[row_new][col_new]
        @chess_board.board[row_new][col_new] = @chess_board.board[row][col]
        @chess_board.board[row][col] = Piece.new(@empty_block)

        if temp.colour == "Black"
            @black_taken << temp.name
        else
            @white_taken << temp.name
        end
        @chess_board.draw_board
        display_taken_pieces
    end

    def display_taken_pieces
        print "#{@black_taken.join("")} "
        puts ""
        print "#{@white_taken.join("")} "
        puts ""
    end


end

a = Game.new
