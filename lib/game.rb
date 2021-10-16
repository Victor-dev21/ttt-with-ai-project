require_relative './board'
require_relative './Player'
require_relative './players/human'
require_relative './players/computer'
class Game
	attr_accessor :board,:player_1,:player_2
	def initialize(player_1 =Players::Human.new("X"),player_2= Player::Computer.new("O"),board=Board.new)
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
     input = current_player.move(@board)
     if @board.valid_move?(input)
			 #update the cell with current player token
       @board.update(input, current_player)
			 #invalid input
     else puts "Enter a number 1-9:"
       @board.display
       turn
     end
     @board.display
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
game = Game.new
game.play
