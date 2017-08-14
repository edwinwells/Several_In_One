require_relative "gameboard.rb"

class Terminal

=begin
 The following function "showboard(currentBoard)"
 articulates the display,
 with top & bottom borders;
 with a1 in lower-left corner; and
 with c3 in upper-right corner:
=end
	def showboard(currentBoard)
	        puts ""
	        print "********" + " SQUARES LEGEND"
	        puts ""
	        print " " + "#{currentBoard[:a3]}" +
	        	  " " + "#{currentBoard[:b3]}" +
	        	  " " + "#{currentBoard[:c3]}"
	        print "     a3|b3|c3"
	        puts ""
	        print " " + "#{currentBoard[:a2]}" +
	        	  " " + "#{currentBoard[:b2]}" +
	        	  " " + "#{currentBoard[:c2]}"
	        print "     a2|b2|c2"
	        puts ""
	        print " " + "#{currentBoard[:a1]}" +
	        	  " " + "#{currentBoard[:b1]}" +
	        	  " " + "#{currentBoard[:c1]}"
	        print "     a1|b1|c1"
	        puts ""
	        puts ""
	        print "********"
	        puts ""
	end
end