require "spec_helper"

module Ludo


  describe Game do

    before do
      @game = Game.new
    end

    context "#initialize" do

      it "initializes the game with a random number of players between 2 and 4" do
        expect(
          @game.players.count.between?(2,4)).to be true
      end
    end

    context "#set players" do

      it "sets players" do
        expect(@game.players.count).to be_between(2, 4).inclusive
      end

      it "checks the color of the players" do
        expect(@game.players[0].color).to eq("Red")
        expect(@game.players[1].color).to eq("Blue")
        expect(@game.players[2].color).to eq("Green") if @game.players.count > 2
        expect(@game.players[3].color).to eq("Black") if @game.players.count > 3
      end

    end

  end
end




