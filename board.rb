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
  
  def display
    puts '  0  1  2  3  4  5  6  7'
    @grid.each_with_index do |row, idx|
      display_grid = []
      row.each do |cell|
        if cell == nil
          display_grid << ' - '
        else
          display_grid << cell.display_value
        end
      end
      print "#{idx}"
      display_grid.each do |square|
        print square
      end

      print "\n"
    end
  end

  def dup
    new_board = Board.new()
    @grid.each_with_index do |row, idx|
      row.each_with_index do |square, j|
        new_board[[idx, j]] = square.dup(new_board) unless square == nil
      end
    end
    new_board
  end
end
