require_relative 'board'
require_relative 'human_player'

class Game
    attr_reader :board, :display, :current_player, :players
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = {
            white: HumanPlayer.new(:white, @display),
            black: HumanPlayer.new(:black, @display)
        }
        @current_player = :white
    end

    def play
        until @board.checkmate?(@current_player)
            begin
                start_pos, end_pos = @players[@current_player].make_move(board)
                @board.move_piece(current_player, start_pos, end_pos)

                @current_player = (current_player == :white ? :black : :white)
            rescue StandardError => e
                @display.notifications[:error] = e.message
                retry
            end
        end
        display.render
        puts "Checkmate! #{@current_player} loses."
    end

end

if $PROGRAM_NAME == __FILE__
  Game.new.play
end