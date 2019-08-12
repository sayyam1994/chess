require_relative "piece"

class Board 

    attr_accessor :board

    W = "White".freeze
    B = "Black".freeze

    def initialize
        assign_white_utfs
        assign_black_utfs
        assign_empty_block_utf
        create_empty_board
        add_pieces_to_board
        #draw_board
    end

    def assign_white_utfs
        @w_pawn = "\u265F "
        @w_rook = "\u265C "
        @w_knight = "\u265E "
        @w_bishop = "\u265D "
        @w_queen = "\u265B "
        @w_king = "\u265A "
    end
    
    def assign_black_utfs
        @b_pawn = "\u2659 "
        @b_rook = "\u2656 "
        @b_knight = "\u2658 "
        @b_bishop = "\u2657 "
        @b_queen = "\u2655 "
        @b_king = "\u2654 "
    end

    def assign_empty_block_utf
        @empty_block = "\u26F6 "
    end


    def create_empty_board
        @board = Array.new(8) { Array.new(8, Piece.new(@empty_block)) }
    end

    def add_pawns
        for j in 0..7
            @board[1][j] = Pawn.new(@b_pawn, B)
            @board[6][j] = Pawn.new(@w_pawn, W)
        end
        #@board[4][2] = Pawn.new(@b_pawn, B)
        #@board[5][2] = Pawn.new(@w_pawn, W)   
    end

    def add_rook
        @board[0][0] = Rook.new(@b_rook, B)
        @board[0][7] = Rook.new(@b_rook, B)
        @board[7][0] = Rook.new(@w_rook, W)
        @board[7][7] = Rook.new(@w_rook, W)
    end

    def add_knight
        @board[0][1] = Knight.new(@b_knight, B)
        @board[0][6] = Knight.new(@b_knight, B)
        @board[7][1] = Knight.new(@w_knight, W)
        @board[7][6] = Knight.new(@w_knight, W)
    end

    def add_bishop
        @board[0][2] = Bishop.new(@b_bishop, B)
        @board[0][5] = Bishop.new(@b_bishop, B)
        @board[1][2] = Bishop.new(@w_bishop, W)
        @board[7][5] = Bishop.new(@w_bishop, W)
    end

    def add_king
        @board[0][4] = King.new(@b_king, B)
        @board[7][4] = King.new(@w_king, W)
    end

    def add_queen
        @board[0][3] = Queen.new(@b_queen, B) 
        @board[7][3] = Queen.new(@w_queen, W)
    end

    def add_pieces_to_board
        add_pawns
        add_rook
        add_knight
        add_bishop
        add_king
        add_queen
    end

    def draw_board
        for i in 0..7
            print " #{i + 1}  "
            for j in 0..7
                print "#{@board[i][j].name}"
            end
            puts ""
        end
        puts ""
        print "    A B C D E F G H "
        puts ""
        puts ""
    end

end

#a = Board.new
