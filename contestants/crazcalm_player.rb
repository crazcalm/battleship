class Crazcalm_player

	attr_accessor :ships_xy

	def name
		Crazcalm
	end

	def new_game
		#	This is called whenever a game starts. 
		#It must return the initial positioning of the fleet
		# as an array of 5 arrays, one for each ship. 
		#The format of each array is:

		#[x, y, length, orientation]
		#orientation:  :across or :down

		@ships_xy = [] # hold all taken positions
		my_ships  = [] 

		my_ships = [5,4,3,3,2].collect {|ship| place_ships(ship)}
		
		my_ships
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


	def place_ships(ship)

		orientation = ship_orientation()
		x, y        = random_xy(ship, orientation)

		tempt_xy    = spaces(x,y, ship, orientation)
	
		start_pos = availability_check(tempt_xy)? [x, y, ship, orientation]	: place_ships(ship)
	end

	def ship_orientation
		rand > 0.5? :across : :down
	end
	
	def random_xy(ship, orientation)
	
		if orientation == :across
			x = rand(10 - ship)
			y = rand(10)

		else
			x = rand(10)
			y = rand(10 - ship)
		end

		[x,y]		
	end

	def spaces(x, y, ship, orientation)

		if orientation == :across
			tempt_xy = (x...x+ship).zip([y]*ship)
		else
			tempt_xy = ([x]*5).zip((y...y+ship))
		end

		tempt_xy
	end

	def availability_check(tempt_xy)
		
		tempt_xy.each do |pos|

			if ships_xy.include?(pos)
				return false
			end
		end
		tempt_xy.each {|pos| ships_xy << pos}
		
		true
	end

end


test = Crazcalm_player.new
p test.new_game
p test.ships_xy
