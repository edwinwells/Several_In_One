require_relative "gameboard.rb"

class Player

	def initialize(input_name)
		@player = input_name
	end

   def get_move(newgame, player_name, square_sought)
      newgame.set_position(square_sought, player_name)
   end

end

class ComputerSequential < Player

	def get_move(newgame, player_name)
		vacant_squares = Array.new
    	(newgame.setup).each do |key, value|
	 		if newgame.setup[key] == " "
	           	vacant_squares.push(key)
	        end
	    end             
		square_sought = vacant_squares[0]
		newgame.set_position(square_sought, player_name)
	end

end

class ComputerRandom < Player

	def get_move(newgame, player_name)

		vacant_squares = Array.new
    	(newgame.setup).each do |key, value|
	 		if newgame.setup[key] == " "
	           	vacant_squares.push(key)
	        end
	    end
	# .sample chooses a random index value from vacant_squares:            
		square_sought = vacant_squares.sample
		newgame.set_position(square_sought, player_name)
		puts ""
	end
end

class ComputerUnbeatable < Player

	def get_move(newgame, player_name)

		vacant_squares = Array.new
    	(newgame.setup).each do |key, value|
	 		if newgame.setup[key] == " "
	           	vacant_squares.push(key)
	     end
	   end

	    square_sought = case vacant_squares.count
		#ideal first move for X is a corner square:
   			when 9
   				"a1"
		#ideal second move for X, if O has taken b2, is the opposite corner square, otherwise, if O has taken a corner, X's second move should take any vacant corner:
   			when 7
				if newgame.setup >= {a1: "X", c3: "O"}
   					"a3"
   				elsif newgame.setup >= {a1: "X", b2: "O"} ||
					  newgame.setup >= {a1: "X", c1: "O"} ||
				   	  newgame.setup >= {a1: "X", a3: "O"}
   					"c3"
		#ideal second move for X, if O has taken a2, b3, b1, or c2, is b2:
   				elsif newgame.setup >= {a1: "X", a2: "O"} ||
   				      newgame.setup >= {a1: "X", b3: "O"} ||
   				      newgame.setup >= {a1: "X", b1: "O"} ||
   				      newgame.setup >= {a1: "X", c2: "O"}
   					"b2"
   				end
		# if then O takes an edge, then X must block, and this will force O to block next move:
   			when 5
   				if newgame.setup >= {a1: "X", b2: "O", c3: "X", c2: "O"} ||
   				      newgame.setup >= {a1: "X", c3: "O", a3: "X", c2: "O"} ||
   				      newgame.setup >= {a1: "X", c3: "O", a3: "X", b3: "O"} ||
   				      newgame.setup >= {a1: "X", c3: "O", a3: "X", b2: "O"} ||
   				      newgame.setup >= {a1: "X", c3: "O", a3: "X", c1: "O"} ||
   				      newgame.setup >= {a1: "X", c3: "O", a3: "X", b1: "O"}			
   					"a2"
   				elsif newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O",} ||
   				      newgame.setup >= {a1: "X", c3: "O", a3: "X", b3: "O"}
   					"b1"
   				elsif newgame.setup >= {a1: "X", b2: "O", c3: "X", a2: "O",} ||
   					  newgame.setup >= {a1: "X", c3: "O", b2: "X", c1: "O"}
   					"c2"
   				elsif newgame.setup >= {a1: "X", b2: "O", c3: "X", b1: "O",} ||
   					  newgame.setup >= {a1: "X", c3: "O", b2: "X", a3: "O"}
   					"b3"
   		#if O has taken a corner on his first move (weakest,) and X has taken an additional corner (strongest,) X will win by taking the last corner, creating a "fork":
   				elsif newgame.setup >= {a1: "X", c3: "O", a3: "X", a2: "O"} ||
   				      newgame.setup >= {a1: "X", a3: "O", c3: "X", b2: "O"} ||
   				      newgame.setup >= {a1: "X", c3: "O", b2: "X", c2: "O"}
   					"c1"
   				elsif newgame.setup >= {a1: "X", c1: "O", c3: "X", b2: "O"} ||
   				      newgame.setup >= {a1: "X", c3: "O", b2: "X", a2: "O"} ||
   				      newgame.setup >= {a1: "X", c3: "O", b2: "X", b1: "O"} ||
   				      newgame.setup >= {a1: "X", c3: "O", b2: "X", b3: "O"}			
   					"a3"
   		#or if O misses the block:
   				elsif newgame.setup >= {a1: "X", a3: "O", c3: "X", a2: "O"} ||
   				      newgame.setup >= {a1: "X", a3: "O", c3: "X", b3: "O"} ||
   				      newgame.setup >= {a1: "X", a3: "O", c3: "X", c2: "O"} ||
   				      newgame.setup >= {a1: "X", a3: "O", c3: "X", c1: "O"} ||
   				      newgame.setup >= {a1: "X", a3: "O", c3: "X", b1: "O"} ||
   				      newgame.setup >= {a1: "X", c1: "O", c3: "X", b1: "O"} ||
   				      newgame.setup >= {a1: "X", c1: "O", c3: "X", b3: "O"} ||
   				      newgame.setup >= {a1: "X", c1: "O", c3: "X", a3: "O"} ||
   				      newgame.setup >= {a1: "X", c1: "O", c3: "X", a2: "O"} ||
   				      newgame.setup >= {a1: "X", c1: "O", c3: "X", c2: "O"}		      
   					"b2"
   		#if O starts with an edge, then misses a block:
   				elsif newgame.setup >= {a1: "X", a3: "O", b2: "X", a2: "O"} ||
   				      newgame.setup >= {a1: "X", a3: "O", b2: "X", b3: "O"} ||
   				      newgame.setup >= {a1: "X", a3: "O", b2: "X", c2: "O"} ||
   				      newgame.setup >= {a1: "X", a3: "O", b2: "X", c1: "O"} ||
   				      newgame.setup >= {a1: "X", a3: "O", b2: "X", b1: "O"} ||
   				      newgame.setup >= {a1: "X", b3: "O", b2: "X", b1: "O"} ||
   				      newgame.setup >= {a1: "X", b3: "O", b2: "X", c1: "O"} ||
   				      newgame.setup >= {a1: "X", b3: "O", b2: "X", c2: "O"} ||
   				      newgame.setup >= {a1: "X", b3: "O", b2: "X", a2: "O"} ||
   				      newgame.setup >= {a1: "X", b3: "O", b2: "X", a3: "O"} ||
   				      newgame.setup >= {a1: "X", c2: "O", b2: "X", b1: "O"} ||
   				      newgame.setup >= {a1: "X", c2: "O", b2: "X", c1: "O"} ||
   				      newgame.setup >= {a1: "X", c2: "O", b2: "X", a2: "O"} ||
   				      newgame.setup >= {a1: "X", c2: "O", b2: "X", a3: "O"} ||
   				      newgame.setup >= {a1: "X", c2: "O", b2: "X", b3: "O"} ||
   				      newgame.setup >= {a1: "X", b1: "O", b2: "X", a2: "O"} ||
   				      newgame.setup >= {a1: "X", b1: "O", b2: "X", a3: "O"} ||
   				      newgame.setup >= {a1: "X", b1: "O", b2: "X", b3: "O"} ||
   				      newgame.setup >= {a1: "X", b1: "O", b2: "X", c2: "O"} ||
   				      newgame.setup >= {a1: "X", b1: "O", b2: "X", c1: "O"} ||
   				      newgame.setup >= {a1: "X", a2: "O", b2: "X", c1: "O"}
   					"c3"
   				end

   			when 3
   		#after X has played a2:
   				if newgame.setup >= {a1: "X", b2: "O", c3: "X", c2: "O", a2: "X", b3: "O"} ||
   				   newgame.setup >= {a1: "X", b2: "O", c3: "X", c2: "O", a2: "X", b1: "O"} ||
   				   newgame.setup >= {a1: "X", b2: "O", c3: "X", c2: "O", a2: "X", c1: "O"} ||
   				   newgame.setup >= {a1: "X", b2: "O", c3: "X", b1: "O", b3: "X", c2: "O"} ||
   				   newgame.setup >= {a1: "X", b2: "O", c3: "X", b1: "O", b3: "X", c1: "O"} ||
   				   newgame.setup >= {a1: "X", b2: "O", c3: "X", b1: "O", b3: "X", a2: "O"} ||
   				   newgame.setup >= {a1: "X", b2: "O", c3: "X", a2: "O", c2: "X", c1: "O"} ||
   				   newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", b1: "X", c1: "O"} ||
   				   newgame.setup >= {a1: "X", b2: "O", c3: "X", c2: "O", a2: "X", b1: "O"} ||
   				   newgame.setup >= {a1: "X", c2: "O", b2: "X", c3: "O", c1: "X", b1: "O"} ||
   				   newgame.setup >= {a1: "X", c2: "O", b2: "X", c3: "O", c1: "X", b1: "O"}   				   
   				   "a3"
   		#after X has played b1:
   				elsif newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", b1: "X", a3: "O"} ||
   				    newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", b1: "X", a2: "O"} ||
   				    newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", b1: "X", c2: "O"} ||
   				    newgame.setup >= {a1: "X", a2: "O", b2: "X", c3: "O", a3: "X", c2: "O"} ||
   		#after X has played c2:
   				    newgame.setup >= {a1: "X", b2: "O", c3: "X", a2: "O", c2: "X", a3: "O"} ||
   				    newgame.setup >= {a1: "X", b2: "O", c3: "X", a2: "O", c2: "X", b3: "O"} ||
   				    newgame.setup >= {a1: "X", b2: "O", c3: "X", a2: "O", c2: "X", b1: "O"} ||
   		#but if O blocks, X in turn must block:
   				    newgame.setup >= {a1: "X", b2: "O", c3: "X", c2: "O", a2: "X", a3: "O"} ||
   				    newgame.setup >= {a1: "X", b2: "O", c3: "X", b1: "O", b3: "X", a3: "O"} ||
   				    newgame.setup >= {a1: "X", b3: "O", b2: "X", c3: "O", a3: "X", a2: "O"} ||
   				    newgame.setup >= {a1: "X", b3: "O", b2: "X", c3: "O", a3: "X", b1: "O"} ||
   				    newgame.setup >= {a1: "X", b3: "O", b2: "X", c3: "O", a3: "X", c2: "O"} ||
   				    newgame.setup >= {a1: "X", b1: "O", b2: "X", c3: "O", a3: "X", b3: "O"} ||
   				    newgame.setup >= {a1: "X", b1: "O", b2: "X", c3: "O", a3: "X", c2: "O"} ||
   				    newgame.setup >= {a1: "X", b1: "O", b2: "X", c3: "O", a3: "X", a2: "O"}  				      
   					"c1"
   		#following weakest play by O (cf above,) X wins thru' the fork:
   				elsif newgame.setup >= {a1: "X", c3: "O", a3: "X", a2: "O", c1: "X", b3: "O"} ||
   				    newgame.setup >= {a1: "X", c3: "O", a3: "X", a2: "O", c1: "X", b2: "O"} ||
   				    newgame.setup >= {a1: "X", a3: "O", c3: "X", b2: "O", c1: "X", c2: "O"} ||
   				    newgame.setup >= {a1: "X", c2: "O", b2: "X", c3: "O", c1: "X", a2: "O"} ||
   				    newgame.setup >= {a1: "X", c2: "O", b2: "X", c3: "O", c1: "X", a3: "O"} ||
   				    newgame.setup >= {a1: "X", c2: "O", b2: "X", c3: "O", c1: "X", b3: "O"}
   					"b1"
   				elsif newgame.setup >= {a1: "X", c3: "O", a3: "X", a2: "O", c1: "X", b1: "O"} ||
   				      newgame.setup >= {a1: "X", c3: "O", a3: "X", a2: "O", c1: "X", c2: "O"}
   					"b2"
   				elsif newgame.setup >= {a1: "X", a3: "O", c3: "X", b2: "O", c1: "X", b1: "O"} ||
   				      newgame.setup >= {a1: "X", a3: "O", c3: "X", b2: "O", c1: "X", a2: "O"} ||
   				      newgame.setup >= {a1: "X", a3: "O", c3: "X", b2: "O", c1: "X", b3: "O"} ||
   				      newgame.setup >= {a1: "X", a2: "O", b2: "X", c3: "O", a3: "X", c1: "O"}
   					  "c2"
   				elsif newgame.setup >= {a1: "X", b1: "O", b2: "X", c3: "O", a3: "X", c1: "O"} ||
   				      newgame.setup >= {a1: "X", b3: "O", b2: "X", c3: "O", a3: "X", c1: "O"} ||
   				      newgame.setup >= {a1: "X", b2: "O", c3: "X", c1: "O", a3: "X", b3: "O"}
   					  "a2"
   				elsif newgame.setup >= {a1: "X", b2: "O", c3: "X", c1: "O", a3: "X", a2: "O"} ||
   				      newgame.setup >= {a1: "X", b2: "O", c3: "X", c1: "O", a3: "X", c2: "O"} ||
   				      newgame.setup >= {a1: "X", b2: "O", c3: "X", c1: "O", a3: "X", b1: "O"}
   					  "b3"
   				end

   		#finally, O must either block, or lose:
   			when 1
   				if newgame.setup >= {a1: "X", b2: "O", c3: "X", c2: "O", a2: "X", a3: "O", c1: "X", b1: "O"} ||
   				   newgame.setup >= {a1: "X", b2: "O", c3: "X", a2: "O", c2: "X", c1: "O", a3: "X", b1: "O"} ||
   				   newgame.setup >= {a1: "X", a2: "O", b2: "X", c3: "O", a3: "X", c1: "O", c2: "X", b1: "O"}
   					"b3"
   				elsif newgame.setup >= {a1: "X", b2: "O", c3: "X", c2: "O", a2: "X", a3: "O", c1: "X", b3: "O"} ||
   				      newgame.setup >= {a1: "X", b2: "O", c3: "X", a2: "O", c2: "X", c1: "O", a3: "X", b3: "O"} ||
   				      newgame.setup >= {a1: "X", a2: "O", b2: "X", c3: "O", a3: "X", c1: "O", c2: "X", b3: "O"}
   				      "b1"
   				elsif newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", b1: "X", c1: "O", a3: "X", a2: "O"} ||
   					  newgame.setup >= {a1: "X", b2: "O", c3: "X", b1: "O", b3: "X", a3: "O", c1: "X", a2: "O"}
   					  "c2"
   				elsif newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", b1: "X", c1: "O", a3: "X", c2: "O"} ||
   				      newgame.setup >= {a1: "X", b2: "O", c3: "X", b1: "O", b3: "X", a3: "O", c1: "X", c2: "O"} ||
   				      newgame.setup >= {a1: "X", c2: "O", b2: "X", c3: "O", c1: "X", b3: "O", a3: "X", b1: "O"}
   					  "a2"
   				end

		#ideal first move for O, if X has taken b2, is a corner square:
   			when 8
   				if newgame.setup >= {b2: "X"}
   					"a1"
   		#alternatively, if X has seized a corner square (strongest,) or any edge square, then O must take the centre:	
   				elsif newgame.setup >= {a1: "X"} ||
   				      newgame.setup >= {a3: "X"} ||
   				      newgame.setup >= {c3: "X"} ||
   				      newgame.setup >= {c1: "X"} ||
   				      newgame.setup >= {a2: "X"} ||
   				      newgame.setup >= {b3: "X"} ||
   				      newgame.setup >= {c2: "X"} ||
   				      newgame.setup >= {b1: "X"}
   					  "b2"
   				end
   		#ideal second move for O, if O has taken b2, is the opposite corner square:
   			when 6
   				if newgame.setup >= {a1: "X", b2: "O", c3: "X"} ||
                  newgame.setup >= {a3: "X", b2: "O", c3: "X"} ||
   				   newgame.setup >= {b2: "X", a1: "O", b1: "X"}
   					"b3"
   				elsif newgame.setup >= {a1: "X", b2: "O", a3: "X"} ||
                 newgame.setup >= {a1: "X", b2: "O", a3: "X"} ||
					  newgame.setup >= {b2: "X", a1: "O", c2: "X"} ||
					  newgame.setup >= {a3: "X", b2: "O", b1: "X"}
  					   "a2"
   				elsif newgame.setup >= {a1: "X", b2: "O", a2: "X"} ||
					  newgame.setup >= {a1: "X", b2: "O", b3: "X"} ||
					  newgame.setup >= {b2: "X", a1: "O", c1: "X"} ||
					  newgame.setup >= {b3: "X", b2: "O", c3: "X"} ||
					  newgame.setup >= {c3: "X", b2: "O", a2: "X"} ||
                 newgame.setup >= {a2: "X", b2: "O", b3: "X"}                
   					"a3"
   				elsif newgame.setup >= {a1: "X", b2: "O", c2: "X"} ||
   					  newgame.setup >= {a1: "X", b2: "O", b1: "X"} ||
                    newgame.setup >= {a1: "O", b2: "X", a3: "X"} ||
   				     newgame.setup >= {a1: "O", b2: "X", c3: "X"} ||
   				     newgame.setup >= {c3: "X", b2: "O", c2: "X"} ||
                    newgame.setup >= {a2: "X", b2: "O", c2: "X"}
   					"c1"
   				elsif newgame.setup >= {a1: "X", b2: "O", c1: "X"} ||
   				     newgame.setup >= {b2: "X", a1: "O", b3: "X"} ||
   				     newgame.setup >= {c1: "X", b2: "O", a3: "X"}
   					"b1"
				elsif newgame.setup >= {b2: "X", a1: "O", a2: "X"} ||
					    newgame.setup >= {c1: "X", b2: "O", c3: "X"}
   					"c2"
				elsif newgame.setup >= {b1: "X", b2: "O", c1: "X"} ||
					    newgame.setup >= {a2: "X", b2: "O", a3: "X"} ||
				   	 newgame.setup >= {c1: "X", b2: "O", a2: "X"} ||
                   newgame.setup >= {a2: "X", b2: "O", b1: "X"}
   					"a1" 
   				elsif newgame.setup >= {b3: "X", b2: "O", a3: "X"} ||
				   	  newgame.setup >= {c2: "X", b2: "O", c1: "X"} ||
				   	  newgame.setup >= {c1: "X", b2: "O", b3: "X"} ||
				   	  newgame.setup >= {a3: "X", b2: "O", c2: "X"}
   					"c3"			  					
    			end

   			when 4
   				if newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", a2: "X"} ||
   				    newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", a3: "X"} ||
   				    newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", c2: "X"} ||
   				    newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", c1: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", b3: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", c3: "X"} ||
   				    newgame.setup >= {a1: "O", b2: "X", c3: "X", c1: "O", a2: "X"} ||
   				    newgame.setup >= {a1: "O", b2: "X", c3: "X", c1: "O", a3: "X"} ||
   				    newgame.setup >= {a1: "O", b2: "X", c3: "X", c1: "O", b3: "X"} ||
                   newgame.setup >= {a1: "O", b2: "X", c3: "X", c1: "O", b3: "X"} ||
				       newgame.setup >= {c2: "X", b2: "O", c1: "X", c3: "O", a1: "X"} ||
				   	 newgame.setup >= {c1: "X", b2: "O", b3: "X", c3: "O", a1: "X"} ||
				   	 newgame.setup >= {c1: "X", b2: "O", c3: "X", c2: "O", a2: "X"} ||
				   	 newgame.setup >= {a3: "X", b2: "O", c3: "X", b3: "O", a2: "X"} ||
				   	 newgame.setup >= {a3: "X", b2: "O", c3: "X", b3: "O", a1: "X"} ||
				   	 newgame.setup >= {a3: "X", b2: "O", c3: "X", b3: "O", c2: "X"} ||
				   	 newgame.setup >= {a3: "X", b2: "O", c3: "X", b3: "O", c1: "X"} ||
                   newgame.setup >= {a1: "O", b2: "X", a3: "X", c1: "O", b3: "X"} ||
                   newgame.setup >= {a1: "O", b2: "X", a3: "X", c1: "O", c3: "X"} ||
                   newgame.setup >= {a1: "O", b2: "X", a3: "X", c1: "O", a2: "X"} ||
                   newgame.setup >= {a1: "O", b2: "X", a3: "X", c1: "O", c2: "X"} ||
                   newgame.setup >= {a1: "O", b2: "X", c3: "X", c1: "O", c2: "X"} ||
   					 newgame.setup >= {a1: "X", b2: "O", a2: "X", a3: "O", c1: "X"} ||
   					 newgame.setup >= {a1: "X", b2: "O", b3: "X", a3: "O", c1: "X"}
   				    "b1"
   				elsif newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", b1: "X"} ||
   				    newgame.setup >= {b2: "X", a1: "O", b3: "X", b1: "O", a2: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", b3: "X", b1: "O", a3: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", b3: "X", b1: "O", c2: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", b3: "X", b1: "O", c3: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", a3: "X"} ||
					    newgame.setup >= {b3: "X", b2: "O", c3: "X", a3: "O", c2: "X"} ||
					    newgame.setup >= {b3: "X", b2: "O", c3: "X", a3: "O", b1: "X"} ||
					    newgame.setup >= {b3: "X", b2: "O", c3: "X", a3: "O", a1: "X"} ||
					    newgame.setup >= {b3: "X", b2: "O", c3: "X", a3: "O", a2: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", a2: "X", a3: "O", c3: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", a2: "X", a3: "O", c2: "X"} ||
					    newgame.setup >= {b2: "X", a1: "O", c2: "X", a2: "O", a3: "X"} ||
   					 newgame.setup >= {a1: "X", b2: "O", b3: "X", a3: "O", c3: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", b3: "X", a3: "O", c2: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", b3: "X", a3: "O", b1: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", a2: "X", a3: "O", b1: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", a2: "X", a3: "O", b3: "X"} ||
					    newgame.setup >= {b2: "X", a1: "O", b1: "X", b3: "O", a3: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", b1: "X", b3: "O", c3: "X"} ||
   					 newgame.setup >= {a1: "X", b2: "O", b3: "X", a3: "O", a2: "X"} ||
   					 newgame.setup >= {c3: "X", b2: "O", a2: "X", a3: "O", c2: "X"} ||
                   newgame.setup >= {a2: "X", b2: "O", b1: "X", a1: "O", c3: "X"} ||
                   newgame.setup >= {a2: "X", b2: "O", b1: "X", a3: "O", c3: "X"}
   				    "c1"
   				elsif newgame.setup >= {a1: "X", b2: "O", a3: "X", a2: "O", b3: "X"} ||
   					 newgame.setup >= {a1: "X", b2: "O", a3: "X", a2: "O", c3: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", a3: "X", a2: "O", c1: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", a3: "X", a2: "O", b1: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", c1: "X", a3: "O", a2: "X"} ||
					    newgame.setup >= {b3: "X", b2: "O", c3: "X", a3: "O", c1: "X"} ||
				   	 newgame.setup >= {c1: "X", b2: "O", a2: "X", a1: "O", c3: "X"} ||
   				    newgame.setup >= {b1: "X", b2: "O", c1: "X", a1: "O", c3: "X"} ||
   				    newgame.setup >= {b2: "X", a1: "O", b1: "X", b3: "O", a2: "X"} ||
   				    newgame.setup >= {a3: "X", b2: "O", b1: "X", a2: "O", c1: "X"} ||
   				    newgame.setup >= {a3: "X", b2: "O", b1: "X", a2: "O", c3: "X"} ||
   				    newgame.setup >= {a3: "X", b2: "O", b1: "X", a2: "O", b3: "X"} ||
   				    newgame.setup >= {c3: "X", b2: "O", a2: "X", a3: "O", c1: "X"} ||
                   newgame.setup >= {a2: "X", b2: "O", b1: "X", a3: "O", c3: "X"}       
   				    "c2"
   				elsif newgame.setup >= {a1: "X", b2: "O", a3: "X", a2: "O", c2: "X"} ||
					    newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", b1: "X"} ||
   				    newgame.setup >= {a1: "O", b2: "X", c3: "X", c1: "O", b1: "X"} ||
   				    newgame.setup >= {c1: "O", b2: "X", a3: "X", b1: "O", a1: "X"} ||
   				    newgame.setup >= {c1: "O", b2: "X", a3: "X", b1: "O", a2: "X"} ||
   				    newgame.setup >= {c1: "O", b2: "X", a3: "X", b1: "O", c2: "X"} ||
   				    newgame.setup >= {c1: "X", b2: "O", a3: "X", b1: "O", c3: "X"} ||
   				    newgame.setup >= {c1: "X", b2: "O", a3: "X", b1: "O", c2: "X"} ||
   				    newgame.setup >= {c1: "X", b2: "O", a3: "X", b1: "O", a2: "X"} ||
   				    newgame.setup >= {c1: "X", b2: "O", a3: "X", b1: "O", a1: "X"} ||
   				    newgame.setup >= {b2: "X", a1: "O", c3: "X", c1: "O", b1: "X"} ||
   				    newgame.setup >= {a2: "X", b2: "O", a3: "X", a1: "O", c3: "X"} ||
   				    newgame.setup >= {c3: "X", b2: "O", c2: "X", c1: "O", a3: "X"} ||
   					 newgame.setup >= {a1: "X", b2: "O", c1: "X", b1: "O", a3: "X"} ||
                   newgame.setup >= {a1: "X", b2: "O", c1: "X", b1: "O", c3: "X"} ||
                   newgame.setup >= {a1: "O", b2: "X", a3: "X", c1: "O", b1: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", c1: "X", b1: "O", c2: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", c1: "X", b1: "O", a2: "X"}	    
   					"b3"
   				elsif newgame.setup >= {a1: "X", b2: "O", c2: "X", c1: "O", a2: "X"} ||  
   					 newgame.setup >= {a1: "X", b2: "O", c2: "X", c1: "O", b1: "X"} ||
   					 newgame.setup >= {a1: "X", b2: "O", c2: "X", c1: "O", b3: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", c2: "X", c1: "O", c3: "X"} ||
			          newgame.setup >= {b2: "X", a1: "O", b3: "X", b1: "O", c1: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", c1: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", c2: "X", a2: "O", b3: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", c2: "X", a2: "O", b1: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", c2: "X", a2: "O", c3: "X"} ||
   					 newgame.setup >= {b2: "X", a1: "O", c2: "X", a2: "O", c1: "X"} ||
   				    newgame.setup >= {c3: "X", b2: "O", c2: "X", c1: "O", b1: "X"} ||
   				    newgame.setup >= {c3: "X", b2: "O", c2: "X", c1: "O", a1: "X"} ||
   				    newgame.setup >= {c3: "X", b2: "O", c2: "X", c1: "O", b3: "X"} ||
   				    newgame.setup >= {c3: "X", b2: "O", c2: "X", c1: "O", a2: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", b1: "X", c1: "O", c3: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", b1: "X", c1: "O", c2: "X"} ||
   				    newgame.setup >= {b2: "X", a1: "O", b1: "X", b3: "O", c1: "X"} ||
					    newgame.setup >= {a1: "X", b2: "O", b1: "X", c1: "O", b3: "X"} ||
   				    newgame.setup >= {a1: "X", b2: "O", b1: "X", c1: "O", a2: "X"}    
				    "a3"
   				elsif newgame.setup >= {a1: "X", b2: "O", c2: "X", c1: "O", a3: "X"} ||
   					newgame.setup >= {b2: "X", a1: "O", c1: "X", a3: "O", b1: "X"} ||
   					newgame.setup >= {b2: "X", a1: "O", c1: "X", a3: "O", b3: "X"} ||
   					newgame.setup >= {b2: "X", a1: "O", c1: "X", a3: "O", c3: "X"} ||
   					newgame.setup >= {b2: "X", a1: "O", c1: "X", a3: "O", c2: "X"} ||
					   newgame.setup >= {c1: "X", b2: "O", c3: "X", c2: "O", b1: "X"} ||
					   newgame.setup >= {c1: "X", b2: "O", c3: "X", c2: "O", a1: "X"} ||
					   newgame.setup >= {c1: "X", b2: "O", c3: "X", c2: "O", a3: "X"} ||
					   newgame.setup >= {c1: "X", b2: "O", c3: "X", c2: "O", b3: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c3: "X", b3: "O", b1: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c2: "X", c3: "O", a1: "X"} ||
				      newgame.setup >= {a1: "X", b2: "O", c1: "X", b1: "O", b3: "X"} || 
				      newgame.setup >= {a1: "X", b2: "O", b1: "X", c1: "O", a3: "X"} ||
   					newgame.setup >= {b3: "X", b2: "O", a3: "X", c3: "O", a1: "X"} ||
   				   newgame.setup >= {b2: "X", a1: "O", b1: "X", b3: "O", c2: "X"}
   					"a2"
   				elsif newgame.setup >= {b1: "X", b2: "O", c1: "X", a1: "O", a2: "X"} ||
   				   newgame.setup >= {b1: "X", b2: "O", c1: "X", a1: "O", a3: "X"} ||
   				   newgame.setup >= {b1: "X", b2: "O", c1: "X", a1: "O", b3: "X"} ||
   				   newgame.setup >= {b1: "X", b2: "O", c1: "X", a1: "O", c2: "X"} ||
   				   newgame.setup >= {a2: "X", b2: "O", a3: "X", a1: "O", b1: "X"} ||
   				   newgame.setup >= {a2: "X", b2: "O", a3: "X", a1: "O", b3: "X"} ||
   				   newgame.setup >= {a2: "X", b2: "O", a3: "X", a1: "O", c1: "X"} ||
   				   newgame.setup >= {a2: "X", b2: "O", a3: "X", a1: "O", c2: "X"} ||
				   	newgame.setup >= {c1: "X", b2: "O", a2: "X", a1: "O", c2: "X"} ||
				   	newgame.setup >= {c1: "X", b2: "O", a2: "X", a1: "O", b3: "X"} ||
   				   newgame.setup >= {c1: "O", b2: "X", a3: "X", b1: "O", b3: "X"} ||
   				   newgame.setup >= {c1: "X", b2: "O", a3: "X", b1: "O", b3: "X"} ||
   				   newgame.setup >= {a3: "X", b2: "O", b1: "X", a2: "O", c2: "X"} ||
                  newgame.setup >= {a2: "X", b2: "O", b1: "X", a1: "O", c2: "X"} ||
                  newgame.setup >= {a2: "X", b2: "O", b1: "X", a1: "O", b3: "X"}
   				    "c3"
   				elsif newgame.setup >= {b3: "X", b2: "O", a3: "X", c3: "O", c2: "X"} ||
   					newgame.setup >= {b3: "X", b2: "O", a3: "X", c3: "O", c1: "X"} ||
   					newgame.setup >= {b3: "X", b2: "O", a3: "X", c3: "O", b1: "X"} ||
   					newgame.setup >= {b3: "X", b2: "O", a3: "X", c3: "O", a2: "X"} ||
				   	newgame.setup >= {c2: "X", b2: "O", c1: "X", c3: "O", b3: "X"} || 					
				   	newgame.setup >= {c2: "X", b2: "O", c1: "X", c3: "O", a3: "X"} || 					
				   	newgame.setup >= {c2: "X", b2: "O", c1: "X", c3: "O", a2: "X"} || 					
				   	newgame.setup >= {c2: "X", b2: "O", c1: "X", c3: "O", b1: "X"} ||
				   	newgame.setup >= {c1: "X", b2: "O", b3: "X", c3: "O", a2: "X"} ||
				   	newgame.setup >= {c1: "X", b2: "O", b3: "X", c3: "O", a3: "X"} ||
				   	newgame.setup >= {c1: "X", b2: "O", b3: "X", c3: "O", c2: "X"} ||
				   	newgame.setup >= {c1: "X", b2: "O", b3: "X", c3: "O", b1: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c2: "X", c3: "O", b3: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c2: "X", c3: "O", c1: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c2: "X", c3: "O", b1: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c2: "X", c3: "O", a2: "X"} ||
                  newgame.setup >= {a2: "X", b2: "O", c2: "X", c1: "O", a3: "X"}
   					"a1"
    			end

    		when 2
   				if newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", b1: "X", c1: "O", a2: "X"} ||
				      newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", b1: "X", c1: "O", c2: "X"} ||
				      newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", c3: "X", b1: "O", c1: "X"} ||
				      newgame.setup >= {b1: "X", b2: "O", c1: "X", a1: "O", c3: "X", a2: "O", b3: "X"} ||
				      newgame.setup >= {b1: "X", b2: "O", c1: "X", a1: "O", c3: "X", c2: "O", a2: "X"}	||
				      newgame.setup >= {c2: "X", b2: "O", c1: "X", c3: "O", a1: "X", b1: "O", b3: "X"} ||
				      newgame.setup >= {c1: "X", b2: "O", a2: "X", a1: "O", c3: "X", c2: "O", b3: "X"} ||
				      newgame.setup >= {c1: "X", b2: "O", a2: "X", a1: "O", c3: "X", c2: "O", b1: "X"} ||
				      newgame.setup >= {c1: "X", b2: "O", b3: "X", c3: "O", a1: "X", b1: "O", a2: "X"} ||
				      newgame.setup >= {c1: "X", b2: "O", b3: "X", c3: "O", a1: "X", b1: "O", c2: "X"} ||
				      newgame.setup >= {c1: "X", b2: "O", c3: "X", c2: "O", a2: "X", b1: "O", b3: "X"} ||
				      newgame.setup >= {b2: "X", a1: "O", b1: "X", b3: "O", c2: "X", a2: "O", c1: "X"} ||
				      newgame.setup >= {b2: "X", a1: "O", b1: "X", b3: "O", c2: "X", a2: "O", c3: "X"} ||
                  newgame.setup >= {a1: "O", b2: "X", a2: "X", c2: "O", b1: "X", b3: "O", c1: "X"} ||
                  newgame.setup >= {a2: "X", b2: "O", b1: "X", a1: "O", c3: "X", c1: "O", c2: "X"} ||
                  newgame.setup >= {a2: "X", b2: "O", b1: "X", a1: "O", c3: "X", c1: "O", b3: "X"}
				   "a3"
				elsif newgame.setup >= {a1: "X", b2: "O", c3: "X", b3: "O", b1: "X", c1: "O", a3: "X"} ||
			         newgame.setup >= {b2: "X", a1: "O", b3: "X", b1: "O", c1: "X", a3: "O", c2: "X"} ||
			         newgame.setup >= {b2: "X", a1: "O", b3: "X", b1: "O", c1: "X", a3: "O", c3: "X"} ||
   				   newgame.setup >= {b2: "X", a1: "O", c3: "X", c1: "O", b1: "X", b3: "O", c2: "X"} ||
   				   newgame.setup >= {b2: "X", a1: "O", c3: "X", c1: "O", b1: "X", b3: "O", c2: "X"} ||
				      newgame.setup >= {b1: "X", b2: "O", c1: "X", a1: "O", c3: "X", c2: "O", b3: "X"} ||
				      newgame.setup >= {b1: "X", b2: "O", c1: "X", a1: "O", c3: "X", c2: "O", a3: "X"} ||
				      newgame.setup >= {b1: "X", b2: "O", c1: "X", a1: "O", c3: "X", c2: "O", b3: "X"} ||
   				   newgame.setup >= {c1: "O", b2: "X", a3: "X", b1: "O", b3: "X", c3: "O", a1: "X"} ||
 				   	newgame.setup >= {c1: "X", b2: "O", b3: "X", c3: "O", a1: "X", b1: "O", a3: "X"} ||
   					newgame.setup >= {b2: "X", a1: "O", b1: "X", b3: "O", c1: "X", a3: "O", c3: "X"} ||
                  newgame.setup >= {a1: "O", b2: "X", a3: "X", c1: "O", b1: "X", b3: "O", c2: "X"} ||
   				   newgame.setup >= {c1: "X", b2: "O", a3: "X", b1: "O", b3: "X", c3: "O", a1: "X"} ||
   				   newgame.setup >= {b2: "X", a1: "O", b1: "X", b3: "O", c1: "X", a3: "O", c2: "X"}	   			    
					"a2" 
   				elsif newgame.setup >= {a1: "X", b2: "O", a3: "X", a2: "O", c2: "X", b3: "O", c3: "X"} ||
   					newgame.setup >= {a1: "X", b2: "O", a3: "X", a2: "O", c2: "X", b3: "O", c1: "X"} ||
   					newgame.setup >= {b2: "X", a1: "O", c2: "X", a2: "O", a3: "X", c1: "O", b3: "X"} ||
   					newgame.setup >= {b2: "X", a1: "O", c2: "X", a2: "O", a3: "X", c1: "O", c3: "X"} ||
   					newgame.setup >= {b2: "X", a1: "O", c1: "X", a3: "O", a2: "X", c2: "O", c3: "X"} ||
   					newgame.setup >= {b2: "X", a1: "O", c1: "X", a3: "O", a2: "X", c2: "O", b3: "X"} ||
   					newgame.setup >= {a2: "X", b2: "O", a3: "X", a1: "O", c3: "X", b3: "O", c1: "X"} ||
   					newgame.setup >= {a2: "X", b2: "O", a3: "X", a1: "O", c3: "X", b3: "O", c2: "X"} ||
   				   newgame.setup >= {c3: "X", b2: "O", c2: "X", c1: "O", a3: "X", b3: "O", a2: "X"} ||
   				   newgame.setup >= {c3: "X", b2: "O", c2: "X", c1: "O", a3: "X", b3: "O", a1: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c2: "X", c3: "O", a1: "X", a2: "O", c1: "X"} ||
					   newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", c1: "X", a3: "O", c3: "X"} ||
					   newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", c1: "X", a3: "O", b3: "X"} ||
					   newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", a3: "X", c1: "O", c3: "X"} ||
   				   newgame.setup >= {c3: "X", b2: "O", a2: "X", a3: "O", c1: "X", c2: "O", a1: "X"} ||
                  newgame.setup >= {a2: "X", b2: "O", c2: "X", c1: "O", a3: "X", a1: "O",c3: "X"} ||
                  newgame.setup >= {a2: "X", b2: "O", c2: "X", c1: "O", a3: "X", a1: "O", b3: "X"}
   					"b1"	
   				elsif newgame.setup >= {a1: "X", b2: "O", a3: "X", a2: "O", c2: "X", b3: "O", b1: "X"} ||
   					newgame.setup >= {b3: "X", b2: "O", a3: "X", c3: "O", a1: "X", a2: "O", c2: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c3: "X", b3: "O", b1: "X", a2: "O", c2: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c2: "X", c3: "O", a1: "X", a2: "O", b3: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c2: "X", c3: "O", a1: "X", a2: "O", b1: "X"} ||
                  newgame.setup >= {a1: "O", b2: "X", a2: "X", c2: "O", b1: "X", b3: "O", a3: "X"} ||
				   	newgame.setup >= {b2: "X", a1: "O", b1: "X", b3: "O", c2: "X", a2: "O", a3: "X"} ||
   				   newgame.setup >= {a3: "X", b2: "O", b1: "X", a2: "O", c2: "X", c3: "O", a1: "X"}
   					"c1"
   				elsif newgame.setup >= {a1: "X", b2: "O", b3: "X", a3: "O", c1: "X", b1: "O", a2: "X"} ||
					   newgame.setup >= {a1: "X", b2: "O", b3: "X", a3: "O", c1: "X", b1: "O", c2: "X"} ||
					   newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", a3: "X", c1: "O", b1: "X"} ||
					   newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", a3: "X", c1: "O", b3: "X"} ||
					   newgame.setup >= {a1: "X", b2: "O", c2: "X", c1: "O", a3: "X", a2: "O", b3: "X"} ||
   				   newgame.setup >= {a1: "X", b2: "O", a2: "X", a3: "O", c1: "X", b1: "O", b3: "X"} ||
   				   newgame.setup >= {a1: "X", b2: "O", c1: "X", b1: "O", b3: "X", a2: "O", c2: "X"} ||
   				   newgame.setup >= {b2: "X", a1: "O", b1: "X", b3: "O", c1: "X", a3: "O", a2: "X"} ||
                  newgame.setup >= {a2: "X", b2: "O", c2: "X", c1: "O", a3: "X", a1: "O", b1: "X"}
   					"c3"
   				elsif newgame.setup >= {a1: "X", b2: "O", b3: "X", a3: "O", c1: "X", b1: "O", c3: "X"} ||
			         newgame.setup >= {b2: "X", a1: "O", b3: "X", b1: "O", c1: "X", a3: "O", a2: "X"} ||
   				   newgame.setup >= {b2: "X", a1: "O", c3: "X", c1: "O", b1: "X", b3: "O", a2: "X"} ||
   				   newgame.setup >= {b2: "X", a1: "O", c3: "X", c1: "O", b1: "X", b3: "O", a3: "X"} ||
   				   newgame.setup >= {b2: "X", a1: "O", c3: "X", c1: "O", b1: "X", b3: "O", a3: "X"} ||
   				   newgame.setup >= {b2: "X", a1: "O", c3: "X", c1: "O", b1: "X", b3: "O", a2: "X"} ||
				      newgame.setup >= {b1: "X", b2: "O", c1: "X", a1: "O", c3: "X", a2: "O", a3: "X"} ||
   					newgame.setup >= {a2: "X", b2: "O", a3: "X", a1: "O", c3: "X", b3: "O", b1: "X"} ||
   					newgame.setup >= {b3: "X", b2: "O", a3: "X", c3: "O", a1: "X", a2: "O", b1: "X"} ||
   					newgame.setup >= {b3: "X", b2: "O", a3: "X", c3: "O", a1: "X", a2: "O", c1: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c3: "X", b3: "O", b1: "X", a2: "O", a1: "X"} ||
				   	newgame.setup >= {a3: "X", b2: "O", c3: "X", b3: "O", b1: "X", a2: "O", c1: "X"} ||
				      newgame.setup >= {a1: "X", b2: "O", b1: "X", c1: "O", a3: "X", a2: "O", b3: "X"} ||
				      newgame.setup >= {a1: "X", b2: "O", b1: "X", c1: "O", a3: "X", a2: "O", c3: "X"} ||
                  newgame.setup >= {a1: "O", b2: "X", a2: "X", c1: "O", b1: "X", b3: "O", a3: "X"} ||
				      newgame.setup >= {a1: "X", b2: "O", c1: "X", b1: "O", b3: "X", a2: "O", c2: "X"} ||
				      newgame.setup >= {a1: "X", b2: "O", c1: "X", b1: "O", b3: "X", a2: "O", a3: "X"}
   					"c2"
   				elsif newgame.setup >= {a1: "X", b2: "O", c2: "X", c1: "O", a3: "X", a2: "O", b1: "X"} ||
   					newgame.setup >= {b2: "X", a1: "O", c2: "X", a2: "O", a3: "X", c1: "O", b1: "X"} ||
   					newgame.setup >= {b2: "X", a1: "O", c1: "X", a3: "O", a2: "X", c2: "O", b1: "X"} ||
				   	newgame.setup >= {c2: "X", b2: "O", c1: "X", c3: "O", a1: "X", b1: "O", a2: "X"} ||
				   	newgame.setup >= {c2: "X", b2: "O", c1: "X", c3: "O", a1: "X", b1: "O", a3: "X"} ||
				   	newgame.setup >= {c1: "X", b2: "O", a2: "X", a1: "O", c3: "X", c2: "O", a3: "X"} ||
				   	newgame.setup >= {c1: "X", b2: "O", c3: "X", c2: "O", a2: "X", b1: "O", a1: "X"} ||
				   	newgame.setup >= {c1: "X", b2: "O", c3: "X", c2: "O", a2: "X", b1: "O", a3: "X"} ||
					   newgame.setup >= {c1: "X", b2: "O", c3: "X", c2: "O", a2: "X", b1: "O", a1: "X"} ||
					   newgame.setup >= {c1: "X", b2: "O", c3: "X", c2: "O", a2: "X", b1: "O", a3: "X"} ||					
   				   newgame.setup >= {a1: "X", b2: "O", c2: "X", c1: "O", a3: "X", a2: "O", c3: "X"} ||
					   newgame.setup >= {b2: "X", a1: "O", a2: "X", c2: "O", c1: "X", a3: "O", b1: "X"} ||
				      newgame.setup >= {a1: "X", b2: "O", b1: "X", c1: "O", a3: "X", a2: "O", c2: "X"} ||
					   newgame.setup >= {a1: "X", b2: "O", a2: "X", a3: "O", c1: "X", b1: "O", c2: "X"} ||		
					   newgame.setup >= {a1: "X", b2: "O", a2: "X", a3: "O", c1: "X", b1: "O", c3: "X"} ||
                   newgame.setup >= {a2: "X", b2: "O", b1: "X", a1: "O", c3: "X", c1: "O", a3: "X"}
   					"b3"
   				elsif newgame.setup >= {c3: "X", b2: "O", c2: "X", c1: "O", a3: "X", b3: "O", b1: "X"} ||
   				   newgame.setup >= {c1: "O", b2: "X", a3: "X", b1: "O", b3: "X", c3: "O", a2: "X"} ||
   				   newgame.setup >= {c1: "O", b2: "X", a3: "X", b1: "O", b3: "X", c3: "O", c2: "X"} ||
   				   newgame.setup >= {c1: "X", b2: "O", a3: "X", b1: "O", b3: "X", c3: "O", a2: "X"} ||
   				   newgame.setup >= {c1: "X", b2: "O", a3: "X", b1: "O", b3: "X", c3: "O", c2: "X"} ||
   				   newgame.setup >= {a3: "X", b2: "O", b1: "X", a2: "O", c2: "X", c3: "O", b3: "X"} ||
   				   newgame.setup >= {a3: "X", b2: "O", b1: "X", a2: "O", c2: "X", c3: "O", c1: "X"} ||
   				   newgame.setup >= {c3: "X", b2: "O", a2: "X", a3: "O", c1: "X", c2: "O", b1: "X"} ||
   				   newgame.setup >= {c3: "X", b2: "O", a2: "X", a3: "O", c1: "X", c2: "O", b3: "X"}
   					"a1"
      			end
   			end
   			p square_sought
   			if square_sought == nil
   			#   puts "There has been an error- please record the position, and notify the creator of this game."
   			#   puts ""
   			#   exit
            return nil
   			end   			
			newgame.set_position(square_sought, player_name)
			puts ""

	end

end