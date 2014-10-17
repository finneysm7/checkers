#encoding: utf-8
require './board.rb'
require './pieces.rb'
require './game.rb'

if __FILE__ == $PROGRAM_NAME
  g = Game.new(Board.new)

  g.play
# b = Board.new()
# p b.won?(:white)
end
