require "spec_helper"

module Ludo
  describe Pawn do

    before do
      @pawn = Pawn.new
    end

    context "#initialize" do

      it "is initialized with a status of 'home' and position 0 by default" do
        expect(@pawn.status).to eq 'home'
        expect(@pawn.position).to eq (-1)
      end

    end

    context "#start" do

      it "checks if pawn enters game on correct position based on its" do
        SP.each do |color, pos|
          @pawn.start(SP[color])
          expect(@pawn.status).to eq 'in_play'
          expect(@pawn.position).to eq (pos)
        end
      end

    end

    context "#send_home" do

      it "checks if pawn is sent home" do
        @pawn.start((SP["Black"]))
        @pawn.send_home
        expect(@pawn.status).to eq 'home'
        expect(@pawn.position).to eq (-1)
      end

    end

  end
end
