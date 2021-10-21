require_relative "piece"

class Pawn < Piece
    def symbol
        ' ♟︎ '.colorize(color)
    end

    def moves
        forward_steps + side_attacks
    end

    private

    def at_start_row?
        i, j = self.position 
        if self.color == :white && i == 6
            return true
        elsif self.color == :black && i == 1
            return true
        else
            false
        end
    end

    def forward_dir
        if self.color == :black
            return 1
        end
        -1
    end

    def forward_steps
        current_x, current_y = position
        step = [current_x + forward_dir, current_y]
        return [] unless board.valid_pos?(step) && board[step].empty
        moves = [step]
        if at_start_row?
            second_step = [current_x + forward_dir * 2, current_y]
            moves << second_step if board.valid_pos?(second_step) && board[second_step].empty
        end
        moves

    end

    def side_attacks
        moves = []
        current_x, current_y = position

        side_moves = 
            [[current_x + forward_dir, current_y + 1],
            [current_x + forward_dir, current_y - 1]]

        side_moves.each do |new_position|
            next if !board.valid_pos?(new_position) 
            next if [color, :none].include?(board[new_position].color)
            moves << new_position
        end
        moves
    end
end