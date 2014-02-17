class Crazcalm_player

	attr_accessor :ships_xy, :hit_count, :ships_left, :shots_taken, :target1, :target2, :hits_landed

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
		
		@target2     = []
		@target1		 = []
		@shots_taken = []
		@hit_count   = 0
		@ships_xy    = [] # hold all taken positions
		my_ships     = [] 

		my_ships = [5,4,3,3,2].collect {|ship| place_ships(ship)}
		
		my_ships
	end

	def take_turn(state, ships_remaining)
		
		hit_tracker(state)

		@ships_left ||= ships_remaining.size

		if @ships_left != ships_remaining.size
			hit_count = 0
			target1 = []
			target2 = []
			@ships_left = ships_remaining.size
		end

		case @hit_count
			when 0 then attack = general_attack
			when 1 then attack =  attack_1
			else 
				attack = attack_2
		end

		shots_taken << attack
		return attack

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

	def hit_tracker(state)

		state.each_with_index |row, x|
			row.each_with_index |status, y|
				
				if status == :hit and !@hits_landed.include?([x,y])
						@hit_count += 1
						hits_landed << [x,y]
				end
			end
		end
	end

	def general_attack
		[rand(10), rand(10)]
	end

	def attack_1
		x,y = @hits_landed.last
		
		up, down, left, right = nil, nil. nil, nil

		right  = [x+1, y] if valid_attack(x+1, y)
		left   = [x-1, y] if valid_attack(x-1, y)
		up     = [x, y+1] if valid_attack(x, y+1)
		down   = [x, y-1] if valid_attack(x, y-1)

		options = []
		options << right << left << up << down
		
		valid_shots = []
		options.each do |x|
		
			if !x.nil? and !@shots_taken.include?(x)
				valid_shots << x
			end
		end
		attack = valid_shots[rand(valid_shots.size)]
		
		attack
	end

	def attack_2

		x1, y1 = @hits_landed[-1]
		x2, y2 = @hits_landed[-2]
		
		if x1 == x2
			y_range = ()


	end

	def valid_attack(x,y)
		if (1...10).to_a.include?(x) and (1...10).to_a.include?(y)
			answer = true
		else 
			answer = false
		end

	answer
	end
		
				

	end

end


test = Crazcalm_player.new
p test.new_game
p test.ships_xy
