
class Node  # nodes are the class that makes up the data tree
	
	attr_accessor :square, :parent, :children
	
	def initialize(square, parent=nil)
		@square = square
		@parent = parent
		@children = []
		end

end


class Knight

	attr_accessor :all_squares_covered, :start_position 

	def initialize(start,target)
		@all_squares_covered = false
		@reached_target = false
		@squares_to_visit = create_board(start)
		@start_position = Node.new(start)  #root of data tree
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

				while @squares_to_visit.size > 0 

					squares.each do |x| #each node in the plan route method
						moves.each do |y|
							new_position = [x.square, y].transpose.map { |y| y.reduce(:+)} 
								if check_square(new_position) #check if position is on board	and update squares_to_visit array
									new_node = Node.new(new_position, x)
									new_squares<<new_node #put new node into array that will be passed into this method recursively at the end
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
					return false	#square is not on the board
				end
			end

			if @squares_to_visit.include?(new_square)  #@squares_to_visit is just a checklist of squares that have not been mapped yet
				@squares_to_visit.delete(new_square) 
			end	
	end


	def map_path(target)  #to find path from start to target
		queue = [start_position]
		find_route(queue, target)
	end

	def find_route(queue, target)
		while @reached_target == false	
			node = queue.shift
				if node.square == target
					puts "Here's the path."
					print_route(node)
					@reached_target = true
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




#####################################


def knight_moves(start, target)
	knight = Knight.new(start, target)	
	knight.build_map
	knight.map_path(target)
end

##tests##

knight_moves([3,3], [4,3])
knight_moves([3,3], [0,0])
knight_moves([0,0], [7,0])
knight_moves([2,6], [2,6])