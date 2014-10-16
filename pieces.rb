class Piece
  attr_accessor :pos, :color, :board, :promoted
  def initialize(pos, color, board, promoted = false)
    @pos, @color, @board = pos, color, board
    @promoted = promoted
    @board[pos] = self
  end
  
  def perform_slide(position)
    if slide_moves.include?(position)
      if board.in_board?(position) && board[position] == nil
        board[position], board[self.pos] = self, nil
        self.pos = position
        puts "gets here"
        maybe_promote
        return true
      end
    end
    false
  end
  
  def perform_jump(position)
    if jump_moves.include?(position)
      if board.in_board?(position) && board[position] == nil
        y = (position[0] - self.pos[0]) / 2 + self.pos[0]
        x = (position[1] - self.pos[1]) / 2 + self.pos[1]
        jump_square = board[[y, x]]
        if jump_square != nil && jump_square.color != self.color
          board[position], board[self.pos] = self, nil
          self.pos = position
          board[[y, x]] = nil
          maybe_promote
          return true
        end
      end
    end
    false
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
    up_move = [[1, 1], [1, -1]]
    down_move = [[-1, -1], [-1, 1]]
    unless @promoted
      self.color == :white ? up_move : down_move
    else
      up_move + down_move
    end
  end
  
  def maybe_promote
    if self.color == :white
      @promoted = true if self.pos[0] == 7
    else
      @promoted = true if self.pos[0] == 0
    end
  end

  def display_value
    unless @promoted
      self.color == :white ? " w " : " r "
    else
      self.color == :white ? " W " : " R "
    end
  end

  def perform_moves!(move_sequence)
    if move_sequence.length == 1
      if perform_slide(move_sequence[0])
        perform_slide(move_sequence[0]) 
      elsif perform_jump(move_sequence[0])
        perform_jump(move_sequence[0])
      else
        raise "Could not jump or slide to that position"
      end
    else
      move_sequence.each do |move|
        unless perform_jump(move)
          raise "Could not make those series of jumps"
        end
      end
    end
  end

  def valid_move_seq?(move_sequence)
    new_board = self.board.dup
    new_piece = self.dup(new_board)
    begin
      new_piece.perform_moves!(move_sequence)
    rescue => e
      puts e
      false
    else
      true
    end
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise "Invalid Move ERRERERERERROR"
    end
  end

  def dup(board)
    new_piece = Piece.new(self.pos, self.color, board, self.promoted)
  end
end