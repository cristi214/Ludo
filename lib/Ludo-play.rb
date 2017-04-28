require_relative "./Ludo/version.rb"
require_relative "./Ludo/player.rb"
require_relative "./Ludo/pawn.rb"
require_relative "./Ludo/game.rb"


puts "Welcome. We have the following players:"
Ludo::Game.new.start
