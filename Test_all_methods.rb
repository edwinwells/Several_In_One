require "minitest/autorun"
require_relative "gameboard.rb"
require_relative "player.rb"
require_relative "game.rb"

class Testallmethods < Minitest::Test

=begin	

In game.rb:
X	initialize(p1, p2, reset)
X	check_for_wins(currentBoard, player_name)

=end

#	initialize(p1, p2, reset) method:
	def test_params_of_initialized_game
		game = Game.new("X", "O", "N")
		@player1 = "X"
		@player2 = "O"
		@reset = "N"
		assert_equal(@player1, "X")
		assert_equal(@player2, "O")
		assert_equal(@reset, "N")
	end

#	check_for_wins(currentBoard, player_name) method:
	def test_returns_true_if_win_present
		game = Game.new("X", "O", "N")
		currentBoard = {
			     a1: "X", a2: "O", a3: "X",
			     b1: "O", b2: "X", b3: "O",
			     c1: "O", c2: "X", c3: "X"
		         }
		result = game.check_for_wins(currentBoard, "X")
		assert_equal(true,result)
	end

	def test_returns_nil_if_no_win_present
		game = Game.new("X", "O", "N")
		currentBoard = {
			     a1: "X", a2: "O", a3: "X",
			     b1: "O", b2: "X", b3: "O",
			     c1: "O", c2: "X", c3: "O"
		         }
		result = game.check_for_wins(currentBoard, "X")
		assert_nil(nil,result)
	end


# ********************************************************
=begin
 In gameboard.rb:
X 	initialize()
X 	set_position(position, character)
X 	check_position?(position)
X 	check_full?()
=end

# 	initialize() method:
	def test_params_of_initialized_board
		board = GameBoard.new
		result = {
			     a1: " ", a2: " ", a3: " ",
			     b1: " ", b2: " ", b3: " ",
			     c1: " ", c2: " ", c3: " "
		         }
		assert_equal(board.setup,result)
	end

# 	set_position(position, character) method:
	def test_returns_true_if_specific_square_which_is_vacant_at_initialize_is_populated_after_set_position_method_invoked
		board = GameBoard.new
		board.set_position(:b1, "X")
		result = board.setup
		assert_equal({
			     a1: " ", a2: " ", a3: " ",
			     b1: "X", b2: " ", b3: " ",
			     c1: " ", c2: " ", c3: " "
		         },result)
	end

 #  check_position?(position) method:	
	def test_returns_true_if_specific_square_vacant
		board = GameBoard.new
		board.set_position(:c1, " ")
		result = board.check_position?(:c1)
		assert_equal(true,result)
	end

	def test_returns_false_if_specific_square_already_occupied
		board = GameBoard.new
		board.set_position(:a1, "X")
		result = board.check_position?(:a1)
		assert_equal(false,result)
	end

#   check_full?() method:	

	def test_returns_false_if_any_square_vacant
		board = GameBoard.new
		# board.set_position(:c1, " ")
		result = board.check_full?()
		assert_equal(false,result)
	end

	def test_returns_true_if_all_squares_occupied
		board = GameBoard.new
		board.setup = {
			     a1: "X", a2: "O", a3: "X",
			     b1: "O", b2: "X", b3: "O",
			     c1: "O", c2: "X", c3: "O"
		         }
		result = board.check_full?()
		assert_equal(true,result)
	end

end