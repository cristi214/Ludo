require "spec_helper"

module Ludo
  describe Player do

    context "#initialize" do

      it "raises an exception when initialized with ()" do
        expect { Player.new() }.to raise_error
      end

      it "does not raise an error when initialized with a valid input hash" do
        input = { color: "Red" }
        expect { Player.new(input) }.to_not raise_error
      end

    end

    context "#color" do

      it "returns the color" do
        @player = Player.new("Red")
        expect(@player.color).to eq('Red')
      end

    end

    context "#pawns" do

      it "checks the number of initial pawns" do
        @player = Player.new("Red")
        expect(@player.pawns.count).to eq(4)
      end

      it "checks the initial status and position of the pawns" do
        @player = Player.new("Red")
        @player.pawns.each do |pawn|
          expect(pawn.status).to eq 'home'
          expect(pawn.position).to eq (-1)
        end
      end

      it "removes pawn that has finished" do
        @player = Player.new("Red")
        @player.pawns[0].start(SP["Red"])
        @player.pawns[0].counter = 42
        @player.remove_finished_pawns
        expect(@player.pawns[0].status).to eq('finished')
      end

    end

    context "#player win" do

      it "check if player has finished with all the pawns" do
        @player = Player.new(color: 'red')
        @player.pawns.each {|pawn| pawn.status = 'finished'}
        @player.remove_finished_pawns
        expect(@player.has_won?).to be true
      end

    end

  end
end
