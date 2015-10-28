require 'colorize'
require_relative 'piece'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize
    @empty_piece = EmptyPiece.new
    @grid = Array.new(8) { Array.new(8, @empty_piece) }
  end

  def in_bounds?(pos)
    pos.first.between?(0,7) && pos.last.between?(0,7)
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, piece)
    @grid[row][col] = piece
  end

  def valid_move?(piece, move)
    in_bounds?(move) && !same_team?(piece, move)
  end

  def same_team?(piece, square)
    self[*square].color == piece.color
  end

  def opponent_piece?(piece, square)
    self[*square].class != EmptyPiece && self[*square].color != piece.color
  end

  def in_check?(color)
    if color == :w
      king_pos = find_king(:w)
      return find_all_moves(:b).include?(king_pos)
    else
      king_pos = find_king(:b)
      return find_all_moves(:w).include?(king_pos)
    end
  end

  def find_king(color)
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |square, col_idx|
        if square.class == King && square.color == color
          return [row_idx, col_idx]
        end
      end
    end
  end

  def find_all_moves(color)
    all_moves = []
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |square, col_idx|
        # debugger if square is_a?(Pawn)
        if square.class != EmptyPiece && square.color == color
            all_moves += square.list_moves
        end
      end
    end
    all_moves.uniq
  end


  def checkmate?(color)
    if in_check?(color)
      if find_all_moves.each do |move|
        !valid_moves.include?(move)
      # will be addressed later
      end
    end
    end
  end

  def dup
    dupped = Board.new
    # debugger
    dupped.grid.each_with_index do |row, idx1|
      row.each_with_index do |square, idx2|
        unless square.class == EmptyPiece
          color = self[idx1, idx2].color
          type = self[idx1, idx2].class
          square = type.new(color, [idx1, idx2], dupped)
        end
      end
    end
    dupped
  end

  def move(start, to)
    if self[to[0], to[1]].class == EmptyPiece
      piece = self[start[0], start[1]]
      self[to[0], to[1]] = piece.class.new(piece.color, piece.position, self)
      self[start[0], start[1]] = EmptyPiece.new()
    end

    # self[start].position = to if valid_move?(self[start], to)

  end

end
