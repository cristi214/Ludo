# Ludo

Ludo game

  The number of players is decided random in each game (between 2 and 4).

  Each player has a corresponding color and 4 pawns.

  When the game starts all the pawns have the status 'home'.

  The pawn enters the game when the player rolls 1 or 6.

  The pawns that enter the game are displayed on the board using the players color and the pawn number ( e.g. Blue-1, Red-2).

  If a pawn advances to a cell that is occupied by another pawn of a different color, it eliminates that pawn ( status 'home' and position -1)

  A pawn changes its status to 'finished' when he gets back home after a complete tour ()  counter > 40.

  The player that finishes with all the pawns is the winner.



#how to run


  To start the game, use the terminal, go to 'Ludo/lib'  ==> ruby Ludo-play.rb and follow the instructions.

