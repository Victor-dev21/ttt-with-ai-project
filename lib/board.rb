require_relative '../lib/Player'
class Board
	attr_accessor :cells

	def initialize
		self.reset!
	end
	def reset!
		@cells = Array.new(9," ")
	end

	def display
	    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
	    puts "-----------"
	    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
	    puts "-----------"
	    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
	  end


		def position(pos)
			self.cells[pos.to_i-1]
		end

		def full?
			cells.all?{|i| i== "X" || i=="O"}
		end

		def turn_count
		  cells.count{|token| token == "X" || token == "O"}
		end
		def taken?(index)
			position(index) == "X" ||
			position(index) == "O"

		end
		# test user inpupt of 1-9
		def valid_index?(index)
			index = index.to_i
			index.between?(1,cells.length)
		end


		def valid_move?(index)
			valid_index?(index) && !taken?(index)
	end

	def input_to_index(user_input)
			spot = user_input.to_i - 1
			spot.to_i
	end
	def update(index,player)
			cells[index.to_i-1]= player.token
		end
	end
