module Stepable
    def moves
        moves = []
        current_x, current_y = position 
        move_diffs.each do |dx, dy|
            new_position = [current_x + dx, current_y + dy]
            next if !board.valid_pos?(new_position)
            moves << new_position if board.empty?(new_position) || board[new_position].color != color
        end
        moves

    end

    private 
    def move_diffs
        # subclass implements this
        raise NotImplementedError
    end
end