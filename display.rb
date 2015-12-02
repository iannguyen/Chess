require_relative 'cursorable'
require_relative 'board'

class Display
  include Cursorable
  attr_reader :board

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected = nil
  end

  def render
    system('clear')
    @board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |square, col_idx|
        if @selected == [row_idx, col_idx]
          print square.to_s.colorize(background: :yellow)
        elsif @cursor_pos == [row_idx, col_idx]
          print square.to_s.colorize(background: :green)
        elsif (row_idx + col_idx).even?
          print square.to_s.colorize(background: :blue)
        elsif (row_idx + col_idx).odd?
          print square.to_s.colorize(background: :red)
        end
      end
      print "\n"
    end
    nil
  end

  def select_squares
    if @selected
      @selected = @cursor_pos
    else
      @selected = @cursor_pos
    end
  end

  def move_cursor
    render until get_input
    @cursor_pos
  end
end
