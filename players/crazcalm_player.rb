class Crazcalm_player

	def new_game
		#	This is called whenever a game starts. 
		#It must return the initial positioning of the fleet
		# as an array of 5 arrays, one for each ship. 
		#The format of each array is:

		#[x, y, length, orientation]
		#orientation:  :across or :down
	
	end

	def take_turn(state, ships_remaining)

		#state is a representation of the known state of the 
		#opponent’s fleet, as modified by the player’s shots. 
		#It is given as an array of arrays; the inner arrays 
		#represent horizontal rows. Each cell may be in one of 
		#three states: :unknown, :hit, or :miss. E.g.

		#[[:hit, :miss, :unknown, ...], [:unknown, :unknown, :unknown, ...], ...]
			# 0,0   1,0    2,0              0,1       1,1       2,1


		#ships_remaining is an array of the ships remaining on the opponent's board,
		# given as an array of numbers representing their lengths, longest first. 
		#For example, the first two calls will always be:

		#[5, 4, 3, 3, 2]


		#take_turn must return an array of co-ordinates for the next shot.
	end


end
