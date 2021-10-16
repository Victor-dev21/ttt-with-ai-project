require_relative '../player'
require_relative '../Board'

module Players
	class Human < Player
	def move(position)
		position = gets.strip
	end
	end
end
#human = Players::Human.new("X")
#p human.move(Board.new)
