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
		final_cell_move = find_random_cell(board)
		if(board.cells[4] == " ")
		final_cell_move =	5
		else
			attack = attack_against_opponent(board)
			defend = defend_against_oponent(board)
			puts "attack  = #{ attack}"
			if(attack != false)# we havent found an attacking move

				 final_cell_move = attack
			elsif(defend !=false) # we dont need to defend

				 final_cell_move = defend
			elsif(defend ==false && attack == false)
				 final_cell_move = find_empty_corner_second(board) # find an empty corner

			elsif(board.taken?(final_cell_move))

				 final_cell_move = find_win_move(board)

			end
		end

			final_cell_move
		end

	def find_win_move(board)
		cell_found = false
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

	def attack_against_opponent(board)
		cell_found = false
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

	# we need to loop through the entire
	# board and find two x's within the same combination
	# to defend position
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

	def find_empty_corner(board)
		if(all_corners_filled?(board))
			puts"Im here in this corners filled method"
			return find_win_move(board)
		else
			puts"Im here in this corners find method"
			return corners.find {|corner| board.cells[corner-1] == " "}
		end
	end
	def find_empty_corner_second(board)
 			corners.find {|corner| board.cells[corner-1] == " "}
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
		 array.none?{|value|value == " "}
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
