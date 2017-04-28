module Ludo
  class Player
    attr_reader :color, :pawns

    def initialize(color)
      @color = color
      @pawns = default_pawns
    end

    def remove_finished_pawns
      # check if a pawn has finished
      @pawns.each do |pawn|
        if pawn.counter > 40
          pawn.status = 'finished'
          pawn.position = -1
        end
      end
    end

    def has_won?
      # player has won if all his pawns have the status finished
      @pawns.select{ |pawn| pawn.status == "finished" }.count == 4
    end

    private
      def default_pawns
        Array.new(4) { Pawn.new }
      end
  end
end
