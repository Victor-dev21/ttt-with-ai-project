require_relative '../player'
require_relative '../Board'
require "pry"

class Player::Computer < Player
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

  def move(board)
		find_open_slot(board)
	end
# iterate through the WIN_COMBINATIONS
# find an open slot
#	def find_open_slot(board)
#		open_cell = 0
#		if(board.cells[4]==" ")
#			open_cell = "5"
#		else
#			WIN_COMBINATIONS.each do |combo|

#				if(board.cells[combo[0]]== " " )
#			 		 open_cell=combo[0]+1#return the index
#				elsif(board.cells[combo[1]]== " " )
#			 		 open_cell = combo[1]+1
#				elsif(board.cells[combo[2]]== " ")
#			 		 open_cell = combo[2]+1
#				end
#			end

#		end
#		open_cell
#	end
	# defend first and if combination does not have more than
	# than two x's then go to possible winning combination
	#if combination of opposing player is a win then place token there
	# check to see if the slot against the player
	# is about to win



	def find_open_slot(board)
		if(board.cells[4] == " ")
		 5
	 else
		 return attack_against_opponent(board)
		end
	end


	def attack_against_opponent(board)
		open_cell = -1
		cell_found = false
		WIN_COMBINATIONS.each do |combo|
			hash = Hash.new
			hash[combo[0]] = board.cells[combo[0]]
			hash[combo[1]] = board.cells[combo[1]]
			hash[combo[2]] = board.cells[combo[2]]
			#find a combination with two O and fulfill the empty
			if(hash.values.count("O") == 2 && hash.values.include?(" "))
				cell_found = true
				return open_cell = hash.key(" ")+1
				#else find and open slot
			end
		end # end-loop
		#if an attack move can't be found computer defends
		if(cell_found == false)
			index = defend_against_oponent(board)
			if(index !=false)
				index
			else
				# find_win_move(board)
				#if computer does not need to defend
				#it finds a corner
					return find_empty_corner_second(board)
			end
			#if we cant find possible win we check if we can defend

			#defend_against_oponent(board)
			#if we dont need to defend we find a corner
			#find_empty_corner(board)
		end
	end
	# we need to loop through the entire
	# board and find two x's within the same combination
def defend_against_oponent(board)
	cell_found = false
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

	#in which the computer could find another possible winning move
	def find_win_move(board)
		WIN_COMBINATIONS.each do |combo|
			hash = Hash.new
			hash[combo[0]] = board.cells[combo[0]]
			hash[combo[1]] = board.cells[combo[1]]
			hash[combo[2]] = board.cells[combo[2]]
			# finds a possible win move
		if(hash.values.count("O") == 1 && hash.values.count(" ") == 2)
			return open_cell = hash.key(" ")+1
		end
	end
	return find_empty_corner(board)
end

#ERRORS does not choose a corner when needed to
#causes computer to be trapped

def find_empty_corner(board)

if board.cells[1-1] == "X" && (board.cells[9-1] != "X" && board.cells[9-1] == " ")
	9
elsif board.cells[9-1] == "X" && (board.cells[1-1] != "X" && board.cells[1-1] == " ")
	1
elsif board.cells[3-1] == "X" && (board.cells[7-1] != "X" && board.cells[7-1] == " ")
	7
elsif board.cells[7-1] == "X" && (board.cells[3-1] != "X" && board.cells[3-1] == " ")
	3
elsif(all_corners_filled?(board))
 		 find_open_cell(board)
	else
		# find an empty corner for possible win move disregarding player X
		CORNERS.shuffle!
		CORNERS.sample(1)[0]
		#corners.find {|corner| board.cells[corner] == " "}

end
end

def find_empty_corner_second(board)
	if(all_corners_filled?(board))
		return find_random_cell(board)
	else
		return corners.find {|corner| board.cells[corner] == " "}
	end
end
def corners
    CORNERS.shuffle!
end
	def find_open_cell(board)
		return board.cells.find_index{|cell| cell ==" "}
	end
	# check if all corners are filled
	def all_corners_filled?(board)
		array = []
		corner_1 = board.cells[CORNERS[0]-1]#1
		corner_2 = board.cells[CORNERS[1]-1]#3
		corner_3 = board.cells[CORNERS[2]-1]#9
		corner_4 = board.cells[CORNERS[3]-1]#7
		array += [corner_1,corner_2,corner_3,corner_4]
		#returns true if all corners are filled
		return array.none?{|value|value == " "}
		#corner_4 == " " # this causes game to not crash when all corners are filled
	end

	def find_random_cell(board)
		open_cell = -1
		WIN_COMBINATIONS.each do |combo|
			hash = Hash.new
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
