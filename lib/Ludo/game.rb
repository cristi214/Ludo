module Ludo

  # hash that holds the starting position for each color
  # SP - short for 'starting positions'
  SP = { "Red" => 0, "Blue" => 10, "Green" => 20, "Black" => 30 }

  class Game
    attr_reader :game_status, :players, :current_player

    def initialize(game_status = 'playing')
      @game_status = game_status
      @players = set_players
    end

    def start
       starting_message
      while @game_status != 'finished' do
        game_turn
      end
    end

    private

    def game_turn
      puts "#{@current_player.color} player moves. If the pawn chosed can not move you will lose your turn."
      print_players_pawns
      adv = dice_roll
      pawn_move(adv)
      @current_player.remove_finished_pawns
      check_winner
      print_players_pawns
      # display_board
      set_current_player(adv)
      display_board
    end

    def set_players
      # sets the players ant their colors
      colors = SP.keys[0..(rand(1..3))]
      players = []
      colors.each { |x| players << Player.new(x) }
      players
    end

    def current_player_index
      @players.index(@current_player)
    end

    def set_current_player(dice)
      # set the current player based on the dice roll, if player gets 6 he moves again
      if dice != 6
        if @current_player == @players[-1]
          @current_player = @players[0]
        else
          @current_player = @players[current_player_index + 1]
        end
      else
        @current_player
      end
      puts @current_player.color
    end

    def dice_roll
      # random between 1 to 6
      rand(1..6)
    end

    def print_players_pawns
        # prints the current user pawns status, position, counter
        current_player.pawns.each_with_index do |p, i|
        puts "The pawn #{i} has the status #{p.status}, position on the board #{p.position} and counter #{p.counter}"
      end
    end

    def display_board
      #displays the board and updates the position of the pawns
      @board = Array.new(40) {'X'}
      @players.each do |player|
        player.pawns.each_with_index do |pawn, i|
          @board[pawn.position] = player.color + "-" + i.to_s if pawn.position != -1
        end
      end
      p @board
    end

    def choose_pawn
      #lets player select the pawn he wants to move
      arr = [0,1,2,3]
      puts "#{@current_player.color} choose a pawn! Press the number of the pawn to move it."
      pawn_input = gets.chomp
      return pawn_input.to_i if arr.include?(pawn_input.to_i)
      choose_pawn
    end

    def check_winner
      #check for a winner and changes game status to finished
      if @current_player.has_won?
        puts "#{@current_player.color} has won the game!"
        @game_status = 'finished'
      end
    end

    def starting_message
      # Displays the players in game and the starting player
      display_players
      puts "#{@current_player.color} will start the game."
    end

    def display_players
      # displays the players colors and sets the starting player
      @players.each do |p|
        puts p.color
      end
      @current_player = set_initial_player
    end

    def set_initial_player
      # choses starting player based on dice roll
      results = []
      @players.each { |x| results << dice_roll}
      h = Hash[@players.zip results]
      h.max_by{|key,val| val}[0]
    end

    def pawn_move(adv)
      puts "Dice roll: #{ adv }"
      current_pawn = choose_pawn
      pawn = @current_player.pawns[current_pawn.to_i]

      if pawn.status == 'home'
        #pawn start the game if the player gets 1 or 6, and he starts from the
        #position that corresponds to its color
        if adv ==1 || adv == 6
          pawn.start(SP[current_player.color])
        end
      elsif pawn.status == 'in_play'
        #if the pawn is already in play, it is gonna advance and
        # eliminate other players pawns
        if pawn.position + adv >= @board.length
          pawn.position = (pawn.position + adv) - @board.length
        else
          if @board[pawn.position + adv] != 'X'
            # eliminates the opponents pawn
            dead_pawn = @board[pawn.position + adv].split(/-/)
            if @current_player.color != dead_pawn[0]
              intruder = @players.select{|player| player.color == dead_pawn[0]}
              intruder[0].pawns[dead_pawn[1].to_i].send_home
            end
          end
          pawn.position += adv
        end
        pawn.counter += adv
      else
        puts "Pawn has already finished."
      end

    end

  end
end
