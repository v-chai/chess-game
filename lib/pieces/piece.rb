require "colorize"

class Piece
    attr_reader :color, :board, :empty
    attr_accessor :position
    def initialize(color, board, position, empty=false)
        raise 'invalid color' if !%i(white black).include?(color)
        @color = color
        @board = board
        @position = position
        @board.add_piece(self, @position)
        @empty = empty
    end

    def to_s
        self.symbol.colorize(self.color)
    end

    def valid_moves
        self.moves.select {|move| !move_into_check?(move)}
    end

    private

    def move_into_check?(end_pos)
        board_dup = @board.dup
        board_dup.move_piece!(@position, end_pos)
        board_dup.in_check?(@color)
    end
end