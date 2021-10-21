require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        @board.rows.each_with_index do |row, row_idx|
            colorized_row = []
            row.each_with_index do |piece, col_idx|
                if @cursor.cursor_pos == [row_idx, col_idx] && @cursor.selected
                    colorized_row << piece.symbol.colorize(:color => piece.color, :background => :blue)
                elsif @cursor.cursor_pos == [row_idx, col_idx] && !@cursor.selected
                    colorized_row << piece.symbol.colorize(:color => piece.color, :background => :red)
                elsif
                    [row_idx, col_idx].all?(&:even?) || [row_idx, col_idx].all?(&:odd?)
                    colorized_row << piece.symbol.colorize(:color => piece.color, :background => :gray)
                else
                    colorized_row <<  piece.symbol.colorize(:color => piece.color, :background => :green)
                end
            end
            puts colorized_row.join("")
        end
    end

  
end
        