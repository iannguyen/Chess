require_relative 'board'
require_relative 'display'
require_relative 'cursorable'
require_relative 'piece'

class Game
  attr_accessor :display, :board

  def initialize(board)
    @board = board
    @display = Display.new(@board)
    #add players later
  end

  def set_player(color, row, board)
    board[row,0] = Rook.new(color, [row,0], board)
    board[row,1] = Knight.new(color, [row,1], board)
    board[row,2] = Bishop.new(color, [row,2], board)
    board[row,3] = Queen.new(color, [row,3], board)
    board[row,4] = King.new(color, [row,4], board)
    board[row,5] = Bishop.new(color, [row,5], board)
    board[row,6] = Knight.new(color, [row,6], board)
    board[row,7] = Rook.new(color, [row,7], board)
  end

  def default_board
    set_player(:b, 0, board)
    set_player(:w, 7, board)
    board.grid[1].each_with_index do |space, idx|
      space = Pawn.new(:b, [1, idx], board)
    end
    board.grid[6].each_with_index do |space, idx|
      space = Pawn.new(:w, [6, idx], board)
    end
  end


  def select_squares
    display.select_squares
  end

  def render
    display.render
  end

end
