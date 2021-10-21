require_relative "piece"

class Pawn < Piece
    def symbol
        ' ♟︎ '.colorize(color)
    end

    def moves
        moves = []
        current_x, current_y = position
        forward_steps.each do |step|
            new_position = [current_x + step, current_y]
            next if !board.valid_pos?(new_position)
            moves << new_position if board.empty?(new_position) 
        end
        side_attacks.each do |side_attack|
            dx, dy = side_attack
            new_position = [current_x + dx, current_y + dy]
            next if !board.valid_pos?(new_position) || board[new_position].color == color
            moves << new_position unless board.empty?(new_position)
        end
        moves
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
        if at_start_row?
            [forward_dir, forward_dir*2]
        else
            [forward_dir]
        end
    end

    def side_attacks
        [[forward_dir,1],[forward_dir,-1]]
    end
end