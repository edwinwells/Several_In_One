require_relative "gameboard.rb"
require_relative "terminal.rb"
require_relative "player.rb"
require_relative "game.rb"

def startgame()

	playerX = Player.new("X")
	playerO = Player.new("O")
	reset = "N"
	freshgame = HumanVersusHuman.new(playerX, playerO, reset)

	freshgame.run_game(playerX, playerO)
    if freshgame.reset.downcase == "y"
		startgame() 
    else
        exit
    end
			
end
# startgame()