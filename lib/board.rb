require_relative "pieces"

class Board
    attr_reader :rows
    def initialize
        @rows = Array.new(8) {Array.new}
        @sentinel = NullPiece.instance
        self.place_pieces
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

    def move_piece(start_pos, end_pos)
        piece = self[start_pos]
        raise "No piece here" if piece == sentinel
        raise "Cannot move this piece here" unless piece.moves.include?(end_pos)
        
        piece.position = end_pos
        self[end_pos] = piece 
        self[start_pos] = sentinel
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
        pieces = []
        @rows.each do |row|
            row_symbols = []
            row.each do |piece|
                row_symbols << piece.symbol
            end
        pieces << row_symbols
        end
        pieces
    end
    private
    attr_reader :sentinel

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

   

