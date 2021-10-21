require_relative "pieces"

class Board
    attr_reader :rows
    def initialize(new_board=true)
        @rows = Array.new(8) {Array.new}
        @sentinel = NullPiece.instance
        self.place_pieces if new_board
    end

    def[](pos)
        x,y= pos
        @rows[x][y]
    end

    def[]=(pos,piece)
        x,y= pos
        @rows[x][y] = piece
    end

    def add_piece(piece, pos)
        # raise 'Cannot add piece here' unless empty?(pos)
        self[pos] = piece
    end

    def move_piece(turn_color, start_pos, end_pos)
        piece = self[start_pos]
        if  turn_color != piece.color
            raise "You can't move your opponent's piece"
        elsif !piece.moves.include?(end_pos)
            raise "That piece does not move like that"
        elsif !piece.valid_moves.include?(end_pos)
            raise "This would move you into check"
        end
        move_piece!(start_pos, end_pos) 
    end
    
    def move_piece!(start_pos, end_pos)
        piece = self[start_pos]
        raise "No piece here" if piece == sentinel
        raise "That piece does not move like that" unless piece.moves.include?(end_pos)
        
        self[end_pos] = piece 
        self[start_pos] = sentinel
        piece.position = end_pos
    end

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0, 7) }
    end

    def empty?(pos)
        self[pos].empty?
    end

    def place_pieces
        [:black, :white].each do |color|
            fill_back_row(color)
            fill_front_row(color)
        end
        fill_empty_rows
    end

    def pieces
        @rows.flatten.reject {|piece| piece.color==:none}
    end

    def player_pieces(color)
        pieces.select {|piece| piece.color == color}
    end

    def in_check?(color)
        king_pos = find_king(color)
        pieces.any? do |piece|
            piece.color != color && piece.moves.include?(king_pos)
        end
    end

    def checkmate?(color)
        in_check?(color) &&
          player_pieces(color).none? { |piece| piece.valid_moves.length > 0}
    end

    def dup
        new_board = Board.new(false)
        pieces.each do |piece|
            piece.class.new(piece.color, new_board, piece.pos)
        end
        new_board
    end 

    
    attr_reader :sentinel
    def find_king(color)
        king = pieces.select {|piece| piece.is_a?(King) && piece.color == color}
        king[0].position
    end

    def fill_back_row(color)
        pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        i = 0
        i = 7 if color == :white
        pieces.each_with_index do |piece, j|
            piece.new(color, self, [i,j])
        end
    end

    def fill_front_row(color)
        i = 1
        i = 6 if color == :white
        (0..7).each do |j|
            Pawn.new(color, self, [i,j])
        end
    end

    def fill_empty_rows
        (2..5).each do |row_idx|
            (0..7).each do |col_idx|
                @rows[row_idx][col_idx] = sentinel
            end
        end
    end

end

   

