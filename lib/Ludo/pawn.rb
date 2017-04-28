module Ludo
  class Pawn
    attr_accessor :status, :position, :counter

    def initialize(status = "home", position = -1, counter = 0)
      @status = status
      @position = position
      @counter = counter
    end

    def start(pos)
      #pawn enters the game, starting position is determined by the color
      @status = 'in_play'
      @position = pos
      @counter = 0
    end

    def send_home(status = "home", position = -1, counter = 0)
      # the pawn is sent home
      @status = status
      @position = position
      @counter = counter
    end

  end
end
