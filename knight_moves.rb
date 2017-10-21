






	

class Knight
	attr_accessor :all_squares_covered, :start_position, :found, :board 
	def initialize(start,target)
		@all_squares_covered = false
		@found = false
		@board = create_board(start)
		@start_position = KnightMove.new(start)  #root of data tree
	end

	def create_board(start) #create an array of all the positions on the board that need to be visited.
		board = []
		y = 0
			8.times do 
				(0..7).each do |x|
					square = [x]
						square<<y
							board<<square
				end
					y+=1
			end
			board.delete(start) #take out the starting position as that has already been visited.
		board 
	end

	def build_map  #plans a root of all the possible moves of the knight until every square has been visited at least once, creating a data tree while doing so
		squares = [@start_position]
		plan_route(squares)
	end

	def plan_route(squares)
		moves = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
		new_squares = []

				while @board.size > 0 

					squares.each do |x| #each node in the plan route method
						moves.each do |y|
							new_position = [x.square, y].transpose.map { |y| y.reduce(:+)}
								if check_square(new_position) #check if position is on board	and update visited array
									new_node = KnightMove.new(new_position, x)
									new_squares<<new_node
									x.children<<new_node
								end	
						end
					end
						plan_route(new_squares)
				end	
	end

	def check_square(new_square)
			new_square.each do |x|
				if x < 0 || x > 7
					return false	
				end
			end

			if @board.include?(new_square)  #@board is just a checklist of squares visited
				@board.delete(new_square) 
			end	
	end


	def map_path(target)  #to find path from start to target
		queue = [start_position]
		find_route(queue, target)
	end

	def find_route(queue, target)
		while @found == false	
			puts "called find_route"
			node = queue.shift
				if node.square == target
					puts "Here's the path."
					print_route(node)
					@found = true
				else	
					node.children.each do |x|
						queue<<x
					end			
				end	
				find_route(queue, target)		
		end	
	end

	def print_route(node)
		result = [node.square]
			x = node
				while x.parent
					x = x.parent
					result<<x.square 
				end
				puts result.reverse.inspect
	end	


end


class KnightMove  #KnightMove nodes are the class that makes up the data tree
	attr_accessor :square, :parent, :children
	def initialize(square, parent=nil)
		@square = square
		@parent = parent
		@children = []
		end
end





##################################################################################
def knight_moves(start, target)
	knight = Knight.new(start, target)	
	knight.build_map
	knight.map_path(target)
end


knight_moves([0,0], [1,2])
#knight_moves([3,3], [0,0])
#knight_moves([7,0], [1,1])
#knight_moves([1,1], [7,0])
#knight_moves([4,5], [6,4])