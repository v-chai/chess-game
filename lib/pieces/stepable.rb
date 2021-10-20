module Stepable
    def moves
        moves = []
            move_diffs.each do |dx, dy|
                current_x, current_y = position
                position = [current_x + dx, current_y + dy]
                next if !board.valid_pos?(position)
                moves << position if board.empty?(position) || board[position].color != color
            end
        moves

    end

    private 
    def move_diffs
        # subclass implements this
        raise NotImplementedError
    end
end