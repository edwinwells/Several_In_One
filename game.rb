require_relative "gameboard.rb"
require_relative "player.rb"
require_relative "terminal.rb"
# require_relative "random.rb"

class Game

	attr_accessor :game
	attr_accessor :reset
	attr_accessor :win

	def initialize(p1, p2, reset)
		@game = game
		@player1 = p1
		@player2 = p2
		@reset = reset
		@win = false
		@draw = false
	end

	def check_for_wins(currentBoard, player_name)

		win1 = {a1: "#{player_name}",
			    a2: "#{player_name}",
			    a3: "#{player_name}"}
		win2 = {a1: "#{player_name}",
			    b1: "#{player_name}",
			    c1: "#{player_name}"}
		win3 = {a3: "#{player_name}",
			    b3: "#{player_name}",
			    c3: "#{player_name}"}
		win4 = {c3: "#{player_name}",
			    c2: "#{player_name}",
			    c1: "#{player_name}"}
		win5 = {b3: "#{player_name}",
			    b2: "#{player_name}",
			    b1: "#{player_name}"}
		win6 = {a1: "#{player_name}",
			    b2: "#{player_name}",
			    c3: "#{player_name}"}
		win7 = {a3: "#{player_name}",
			    b2: "#{player_name}",
			    c1: "#{player_name}"}
		win8 = {a2: "#{player_name}",
			    b2: "#{player_name}",
			    c2: "#{player_name}"}

		if currentBoard >= win1 ||
		   currentBoard >= win2 ||
		   currentBoard >= win3 ||
		   currentBoard >= win4 ||
		   currentBoard >= win5 ||
		   currentBoard >= win6 ||
		   currentBoard >= win7 ||
		   currentBoard >= win8 

		    puts " There's a win!"
			puts ""
			puts " #{player_name} wins "
			@win = true
			
		end
	end

	def get_move(currentgame, player_name)
		# p currentgame
		# print " #{player_name}, enter your square! "
		# square = gets.chomp

		until currentgame.check_position?(square) == true do
   #      	print " Invalid entry! Try again..."
			# puts ""
			# print " #{player_name}, enter your square! "
			# square = gets.chomp
		end

		currentgame.set_position(square, player_name)
		puts ""
		# p currentgame
	end

	def game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(newgame, player_name)
		# terminal.showboard(newgame.setup)
		# p player_name
		check_for_wins(newgame.setup, player_name)
		# p win

		# if ((win == false) &&
		#    (newgame.check_full? == true))
		# 		@draw = true
		# 		# p win
		# 		declare_tie(terminal, newgame)
		# elsif win == true
		# 	ask_to_reset_game()

	 #    end

 	end

	def ask_to_reset_game()
		# win = true
		# win = true
	    print "\n Care for another game? (Y or N) "
		@reset = gets.chomp
	end

	def declare_tie(terminal, newgame)
		@draw = true
		print " The game is tie!"
		puts ""
		ask_to_reset_game()
		# terminal.showboard(newgame.setup)
	end

end

class VersusRandom < Game

	def run_game(playerX, playerO, response)

		newgame = GameBoard.new
		terminal = Terminal.new

		if response == "X"
			while win == false && @draw == false do

				puts ""
				if win == false && @draw == false
					get_move(newgame, "X")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "X")
				end

				if win == false && @draw == false
					puts "And..."
					puts "The computer moves!: "
					playerO.get_move(newgame, "O")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "O")	
				end
			end
		end

		if response == "O"
			while win == false && @draw == false do

				puts ""
				if win == false && @draw == false
					puts "And..."
					puts "The computer moves!: "
					playerX.get_move(newgame, "X")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "X")	
				end

				puts ""
				if win == false && @draw == false
					get_move(newgame, "O")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "O")
				end
			end
		end		
	end

end

class VersusSequential < Game

	def run_game(playerX, playerO, response)

		newgame = GameBoard.new
		terminal = Terminal.new

		if response == "X"
			while win == false && @draw == false do

				puts ""
				if win == false && @draw == false
					get_move(newgame, "X")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "X")
				end

				if win == false && @draw == false
					puts "And..."
					puts "The computer moves!: "
					playerO.get_move(newgame, "O")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "O")	
				end
			end
		end

		if response == "O"
			while win == false && @draw == false do

				puts ""
				if win == false && @draw == false
					puts "And..."
					puts "The computer moves!: "
					playerX.get_move(newgame, "X")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "X")	
				end

				puts ""
				if win == false && @draw == false
					get_move(newgame, "O")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "O")
				end
			end
		end		
	end

end
class HumanVersusHuman < Game

	def run_game(playerX, playerO, freshgame)

		# newgame = GameBoard.new
		# terminal = Terminal.new

			while win == false && @draw == false do

				# puts ""
				if win == false && @draw == false
					get_move(freshgame, "X")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "X")
				end

				# puts ""
				if win == false && @draw == false
					get_move(newgame, "O")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "O")
				end

			end
	end

end

class VersusUnbeatable < Game

	def run_game(playerX, playerO, response)

		newgame = GameBoard.new
		terminal = Terminal.new

		if response == "X"
			while win == false && @draw == false do

				puts ""
				if win == false && @draw == false
					get_move(newgame, "X")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "X")
				end

				if win == false && @draw == false
					puts "And..."
					puts "The computer moves!: "
					playerO.get_move(newgame, "O")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "O")	
				end
			end
		end

		if response == "O"
			while win == false && @draw == false do

				puts ""
				if win == false && @draw == false
					puts "And..."
					puts "The computer moves!: "
					playerX.get_move(newgame, "X")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "X")	
				end

				puts ""
				if win == false && @draw == false
					get_move(newgame, "O")
					game_flow_status_to_proceed_or_to_declare_tie_or_to_declare_win_and_if_to_reset_to_new_game(terminal, newgame, "O")
				end
			end
		end		
	end

end