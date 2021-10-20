module Slideable
    DIAGONAL_DIRS = [[-1,1], [1,-1], [1,1], [-1,-1]]
    HORIZONTAL_AND_VERTICAL_DIRS = [[0,-1], [0,1], [1,0], [-1,0]]

    def horizontal_and_vertical_dirs
        HORIZONTAL_AND_VERTICAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        moves = []
        move_dirs.each do |dx, dy|
            moves.concat(keep_moving(dx, dy))
        end
        moves
    end

    private

    def move_dirs
        raise NotImplementedError
    end

    def keep_moving(dx, dy)
        current_x, current_y = position 
        moves = []
        loop do
            current_x, current_y = current_x + dx, current_y + dy
            position = [current_x, current_y]

            break unless self.board.valid_pos?(position)

            if self.board.empty?(position)
                moves << position
            else 
                moves << position if self.board[position].color != color
                break
            end
        end
        moves
            
    end

end