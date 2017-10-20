






	

class Knight
	attr_accessor :all_squares_covered, :squares_covered, :start_position
	def initialize(start,target)
		@all_squares_covered = false
		@squares_covered = []
		@found = false
		@start_position = KnightMove.new(start)
		puts start_position.square.inspect
	end

	def build_map
		@squares_covered<<@start_position.square
		puts @squares_covered
		squares = []
		squares<<start_position
		plan_route(squares)
		puts @squares_covered.inspect
		check
	end

	def check
		start_position.children.each do | x|
			puts x.square.inspect
			
		end
		
	end

	def plan_route(squares)
		moves = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
		
		new_squares = []

				while @all_squares_covered == false

					squares.each do |x|
						moves.each do |y|
							new_position = [x.square, y].transpose.map { |y| y.reduce(:+)}
								if check_square(new_position)
									
									new_square = KnightMove.new(new_position, x)

								@squares_covered<<new_square.square
										
									new_squares<<new_square
									x.children<<new_square
									if @squares_covered.size >= 64
										@all_squares_covered = true
									end
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
				elsif @squares_covered.include?(new_square)
					return false	
				else
					 

				end	

			end		
			
		end


		def map_path(target)
			queue = [start_position]
			find_route(queue, target)
			
		end

		def find_route(queue, target)
			
			
			while @found == false	
				node = queue.shift
				puts node
				puts node.square
					if node.square == target
						puts "found"
						print_route(node)
						@found = true
					else	
						node.children.each do |x|
						queue<<x
					end
						find_route(queue, target)

						
					end		
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


class KnightMove
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


knight_moves([0,0], [7,0])