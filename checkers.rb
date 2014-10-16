class Piece
  attr_accessor :pos, :color, :board
  def initialize(pos, color, board)
    @pos, @color, @board = pos, color, board
    @promoted = false
  end
  
  def perform_slide(pos)
    if slide_moves.include?(pos)
      if board.in_board?(pos) && board[pos] != nil
        self.pos = pos
        maybe_promote
        return true
      else
        return false
      end
    end
    false
  end
  
  def perform_jump(pos)
    
  end
  
  def slide_moves
    moves = []
    move_diffs.each do |move|
      moves << [self.pos[0] + move[0], self.pos[1] + move[1]]
    end
    moves
  end
  
  def jump_moves
    moves = []
    move_diffs.each do |move|
      moves << [self.pos[0] + 2 * move[0], self.pos[1] + 2 * move[1]]
    end
    moves
  end
  
  def move_diffs
    unless @promoted
      if self.color == :white
        up_move = [[1, 1], [1, -1]]
        return up_move
      else
        down_move = [[-1, -1], [-1, 1]]
        return down_move
      end
    else
      return up_move + down_move
    end
  end
  
  def maybe_promote
    if self.color == :white
      @promote = true if self.pos == 7
    else
      @promote = true if self.pos == 0
    end
  end
end

class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(8) { Array.new(8) { nil }}
  end
  
  def in_board?(pos)
    pos[0] < 8 && pos[0] > -1 && pos[1] < 8 && pos[1] > -1
  end
  
  def [](pos)
    @grid[pos[0]][pos[1]]
  end
  
  def []=(pos, piece)
    @grid[pos[0]][pos[1]] = piece
  end
  
end

b = Board.new
red1 = Piece.new([5,5], :red, b)
white1 = Piece.new([4,4], :white, b)
p b.grid
p red1.perform_slide([4,4])
p b.grid
p red1.perform_slide([4,6])
p b.grid
