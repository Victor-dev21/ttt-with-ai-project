require_relative '../player'
require_relative '../Board'
module Players
class Computer < Player
	attr_accessor :board
	WIN_COMBINATIONS = [
		[0, 1, 2],#0
		[3, 4, 5],#1
		[6, 7, 8],#2
		[0, 3, 6],#3
		[1, 4, 7],#4
		[2, 5, 8],#5
		[0, 4, 8],#6
		[6, 4, 2]#7
	]
	CORNERS = [1, 3, 9, 7]
		# steps one and two won't run in computer's first turn
		# 1. Computer first checks if it goes for the win otherwise continue
		# 2. Computer checks if it needs to defend
		# 3. otherwise Find an empty corner
		# 4. on the computer's second turn it will see if it needs to do step 1 or 2
		# otherwise it chooses a corner cell
		# computer will go for an open cell if it is the winning cell
		def move(board)
		if(board.cells[4] == " ")
		return final_cell_move =	"5"
		else
			if(attack_against_opponent(board) != nil)
				 return final_cell_move = attack_against_opponent(board)
			elsif(defend_against_opponent(board) !=nil)
				 return final_cell_move = defend_against_opponent(board)
			elsif(find_empty_corner(board) != nil)
				 return final_cell_move = find_empty_corner(board)
			 elsif(find_move(board) != nil)
	 			 return final_cell_move = find_move(board) # +1
			 elsif(all_corners_filled?(board))
				 return final_cell_move = find_random_cell(board)
			end
		end
	end


	# when win is not in favor of X and O
	# and its the computers turn
	# this method finds a new cell for this scenario
	# X O X
	#   O
	# X X O
	#
	def find_move(board)
		cell_found = nil
			WIN_COMBINATIONS.each do |combo|
				hash = Hash.new
				hash[combo[0]] = board.cells[combo[0]]
				hash[combo[1]] = board.cells[combo[1]]
				hash[combo[2]] = board.cells[combo[2]]
				# finds a possible win move
			if(hash.values.count("O") == 1 && hash.values.count(" ") == 2)
				cell_found = hash.key(" ")+1
			end
		end
		cell_found
	end
	# computer loops through the entire
	# board and finds two O's within the same combination
	# to add final O for the possible win
	def attack_against_opponent(board)
		cell_found = nil
		WIN_COMBINATIONS.each do |combo|
			hash = Hash.new
			hash[combo[0]] = board.cells[combo[0]]
			hash[combo[1]] = board.cells[combo[1]]
			hash[combo[2]] = board.cells[combo[2]]
			# find a combination with two O and fulfill the empty
			# if there isn't any cell_found is false
			if(hash.values.count("O") == 2 && hash.values.include?(" "))
				cell_found = hash.key(" ")+1
			end
		end # end-loop
		cell_found
	end

	# computer loops through the entire
	# board and find two X's within the same combination
	# to defend position
	def defend_against_opponent(board)
		cell_found = nil
		WIN_COMBINATIONS.each do |combo|
			hash = Hash.new
			hash[combo[0]] = board.cells[combo[0]]
			hash[combo[1]] = board.cells[combo[1]]
			hash[combo[2]] = board.cells[combo[2]]
			if(hash.values.count("X") == 2 && hash.values.include?(" "))
				cell_found = hash.key(" ")+1
			end
		end
		cell_found
	end

	def find_empty_corner(board)
			 corners.find{|corner| board.cells[corner-1] == " "}
	end
	# shuffle is used to randomize the first move for the computer
	# this is so the computer won't select the same spot every new game
	def corners
		CORNERS.shuffle!
	end

	# checks if all corners are filled
	def all_corners_filled?(board)
		array = []
		corner_1 = board.cells[CORNERS[0]-1]#1
		corner_2 = board.cells[CORNERS[1]-1]#3
		corner_3 = board.cells[CORNERS[2]-1]#9
		corner_4 = board.cells[CORNERS[3]-1]#7
		array += [corner_1,corner_2,corner_3,corner_4]
		# returns true if none of the corners are empty
		 array.none?{|value|value == " "}
	end


	# this is used in the case where
	# there is only two spots left and no
	# winner will be declared so it just finds a random
	# cell
	def find_random_cell(board)
		open_cell = nil
		WIN_COMBINATIONS.each do |combo|
			hash = Hash.new
			# map index with board value
			hash[combo[0]] = board.cells[combo[0]]
			hash[combo[1]] = board.cells[combo[1]]
			hash[combo[2]] = board.cells[combo[2]]
			if(hash.values.count("X") == 1 && hash.values.include?(" "))
				open_cell = hash.key(" ")+1
			end
		end
		open_cell
	end
end
end
