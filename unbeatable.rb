require_relative "gameboard.rb"
require_relative "terminal.rb"
require_relative "player.rb"
require_relative "game.rb"

def startgame()

#Determine which player will be "X":
	response = ""
	puts""
 		
	until response == "X" || response == "O" do
		print " Will you choose to play as X or O? \n Enter X or O: "
		response = gets.chomp.upcase
		puts ""
 	end

		if response == "X"
		playerX = Player.new("X")
		playerO = ComputerUnbeatable.new("O")
		reset = "N"
		freshgame = VersusUnbeatable.new(playerX, playerO, reset)

	elsif response == "O"
		playerX = ComputerUnbeatable.new("X")
		playerO = Player.new("O")
		reset = "N"
		freshgame = VersusUnbeatable.new(playerX, playerO, reset)
	end

		freshgame.run_game(playerX, playerO, response)

	    if freshgame.reset.downcase == "y"
			startgame() 
	    else
	        exit
	    end

end
startgame()