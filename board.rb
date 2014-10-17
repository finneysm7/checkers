#encoding: utf-8
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
      flag = (idx + 2).even? ? true : false
      row.each_with_index do |cell, j|
        if cell == nil
          if flag == true
            display_grid << ' - ' if (j + 2).even?
            display_grid << ' + ' if (j + 2).odd?
          else
            display_grid << ' - ' if (j + 2).odd?
            display_grid << ' + ' if (j + 2).even?
          end
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

  def starting_board
    @grid.each_with_index do |row, idx|
      color = ((idx < 3) ? :white : :red) 
      row.each_with_index do |square, j|
        if idx < 3 || idx > 4
          if (idx + 2).even?
            grid[idx][j] = Piece.new([idx, j], color, self) if (j + 2).odd?
          else
            grid[idx][j] = Piece.new([idx, j], color, self) if (j + 2).even?
          end
        end
      end
    end
  end
  
  def won?(color)
    otr_color = (color == :white) ? :red : :white
    if pieces(otr_color).empty?
      return true
    end
    false
  end
  
  def pieces(color)
    pieces = []
    @grid.flatten.compact.select {|square| square.color == color}
    # @grid.each_with_index do |row, idx|
#       row.each_index do |j|
#         pieces << self[[idx, j]] if self[[idx, j]] != nil self[[idx, j]].color == color
#       end
#     end
  end
end
