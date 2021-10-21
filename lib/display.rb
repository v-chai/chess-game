require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
    attr_reader :board, :cursor
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        until @cursor.get_input == :ctrl_c
            system("clear")
            puts "Use arrow keys, WASD, or vim to move cursor. Press space or enter to select."
            build_grid.each { |row| puts row.join }
            @cursor.get_input
        end
    end
    
    def build_grid
        @board.rows.map.with_index do |row, row_idx|
            build_row(row,row_idx)
        end
    end

    def build_row(row, row_idx)
        row.map.with_index do |piece, col_idx|
            bg_color = bg_color(row_idx, col_idx)
            piece.to_s.colorize(:background=>bg_color)
        end
    end

    def bg_color(row_idx, col_idx)
        if @cursor.cursor_pos == [row_idx, col_idx] && @cursor.selected
            return :blue
        elsif @cursor.cursor_pos == [row_idx, col_idx] && !@cursor.selected
            return :red
        elsif [row_idx, col_idx].all?(&:even?) || [row_idx, col_idx].all?(&:odd?)
            return :gray
        else
            return :green
        end
    end



    # def render
    #     @board.rows.each_with_index do |row, row_idx|
    #         colorized_row = []
    #         row.each_with_index do |piece, col_idx|
    #             if @cursor.cursor_pos == [row_idx, col_idx] && @cursor.selected
    #                 colorized_row << piece.symbol.colorize(:color => piece.color, :background => :blue)
    #             elsif @cursor.cursor_pos == [row_idx, col_idx] && !@cursor.selected
    #                 colorized_row << piece.symbol.colorize(:color => piece.color, :background => :red)
    #             elsif
    #                 [row_idx, col_idx].all?(&:even?) || [row_idx, col_idx].all?(&:odd?)
    #                 colorized_row << piece.symbol.colorize(:color => piece.color, :background => :gray)
    #             else
    #                 colorized_row <<  piece.symbol.colorize(:color => piece.color, :background => :green)
    #             end
    #         end
    #         puts colorized_row.join("")
    #     end
    # end

  
end


if __FILE__ == $PROGRAM_NAME
    d = Display.new(Board.new)
    d.render
end
        