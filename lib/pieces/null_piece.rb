require "singleton"
require_relative "piece"

class NullPiece < Piece
    include Singleton
    attr_reader :symbol, :empty
    def initialize
        @symbol = "   "
        @color = :none
        @empty = true
    end

end