




class Board

	attr_accessor :all_squares_covered, :squares_covered
	def initialize
		@all_squares_covered = false
		@squares_covered = []
	end

	def place_knight(start,target)
		knight = Node.new(start)
		self.build_map(knight)
	end	


	

	


	def build_map(squares) #build data tree of all knights moves until every square has been landed on at least once.
				new_squares = []
				moves = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]

				while @all_squares_covered == false

					squares.each do |x|
						moves.each do |y|
							new_position = [x.square, y].transpose.map { |y| y.reduce(:+)}
								if check_square(new_position)
									new_squares<<new_position
									new_square = Node.new(new_position, x)
									x.children<<new_square
								end	
						end
					end
				end	
				
		end

		def check_square(new_square)
			new_square.each do |x|
				if x < 0 || x > 7
					return false
				end	
			end		
			
		end

class Node
		attr_accessor :square, :parent, :children

		def initialize(square, parent=nil)
			@parent = parent
			@square = square
			@children = []
			self.add_to_map(square)
		end

		def add_to_map(square)
			
			puts @squares_covered
			unless @squares_covered.include?(square)
				@squares_covered<<square 
			end
			if @squares_covered.size == 64
				@all_squares_covered = true
			end	
		end

	end		






end



def knight_moves(start, target)
		board = Board.new
		board.place_knight(start, target)
		#knight = Node.new(start)
		
			
end	
	


	



puts knight_moves([3,3],[0,0])