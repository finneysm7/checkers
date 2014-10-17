#encoding: utf-8
class Game
	attr_accessor :board
	def initialize(board)
		@board = board
		@color_turn = :white
	end
  
  #:red is pretty much black in this game
	def play
		self.board.starting_board
    
    until self.board.won?(otr_color(@color_turn)) || @break_loop
      begin
        self.board.display
        input = get_user_input
        board[input[0]].perform_moves(input.drop(1), @color_turn)
      rescue => e
        puts e
        retry
      end
      @color_turn == :white ? @color_turn = :red : @color_turn = :white
    end
    game_over_conditions
	end
  
  def otr_color(color)
    color == :white ? :red : :white
  end
  
  def get_user_input
    puts "#{color_to_s}'s turn:"
    puts "Enter a position to move from and a position or positions to move to"
    puts "Like so: verticlehorizontal verticalhorizontal verticalhorizontal ...etc"
    handle_user_input(gets.chomp)
  end
  
  def handle_user_input(string)
    # unless possible_inputs.include?(string)
#       raise "Please enter the correct input"
#     end
    init_arr = string.split(' ')
    result = []
    init_arr.each do |pos|
      result << pos.split('').map{ |i| i.to_i}
    end
    result
  end
  
  def possible_inputs
    #need to figure out how to implement this, could be a very long string
  end
  
  def color_to_s(color = nil)
    if color == nil
      @color_turn == :white ? "White" : "Black"
    else
      color == :white ? "Black" : "White"
    end
  end
  
  def game_over_conditions
    self.board.display
    puts "#{color_to_s(@color_turn)} has won the game"
  end
end