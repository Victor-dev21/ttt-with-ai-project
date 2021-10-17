require_relative './board'
require_relative './Player'
require_relative './players/human'
require_relative './players/computer'
class Game
	attr_accessor :board,:player_1,:player_2
	# change player_2= Players::Human.new("O") to player_2= Players::Computer.new("O")
	# to play against cpu
	def initialize(player_1 =Players::Human.new("X"),player_2= Players::Humangit .new("O"),board=Board.new)
		@player_1 = player_1
		@player_2 = player_2
		@board = board
	end
	WIN_COMBINATIONS =[
		[0,1,2],
		[3,4,5],
		[6,7,8],
		[0,3,6],
		[1,4,7],
		[2,5,8],
		[0,4,8],
		[6,4,2]
	]
	def current_player
		  board.turn_count % 2 == 0 ? player_1 : player_2
	end
	def won?
	    WIN_COMBINATIONS.each do |pos|
	      if(@board.cells[pos[0]] == @board.cells[pos[1]] &&
	      @board.cells[pos[1]] == @board.cells[pos[2]] &&
				# index conversion is done in #taken?
				# the above will return true if all values are " "
				# the taken? method checks if it is an X or O
				@board.taken?(pos[0]+1))
				return pos
				end
	    end
		false
	end
	def draw?
	@board.full? && !won?
	end
	def over?
		draw? || won?
	end

	def winner
		if(won? != false)
		board.cells[won?[0]]
	else
		nil
		end
	end

	def turn
     puts "Enter a number 1-9:"
     input = current_player.move(@board).to_i
     if @board.valid_move?(input)
			 #update the cell with current player token
       @board.update(input, current_player)
			 #invalid input
			 board.display
		 elsif input.between?(1, 9) == false
			 puts"#{input}"
      puts "That is an invalid move"
      turn
			elsif board.taken?(input)
      puts "Position is taken"
      turn
    end
  end


	 def play
		 @board.display
		until(over?)
			turn
		end
		if(won?)
			puts "Congratulations #{winner}!"
		elsif(draw?)
			puts "Cat\'s Game!"
		end
	end

	def start
		play
	end
end
#game = Game.new
#game.play
#run 'ruby lib/game.rb' in terminal
