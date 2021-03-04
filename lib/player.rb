require_relative 'game.rb'

class Player

  def initialize(name,color)
    @name = name
    @color = color
  end

  def make_move(game,move)
    if move =~ /[A-H][1-8][A-H][1-8]/
      if game.piece_at(string_to_coords(move[0..1])) && game.piece_at(string_to_coords(move[0..1])).color == @color
        return game.move_piece(string_to_coords(move[0..1]),string_to_coords(move[2..3]))
      else
        puts "Not a piece you can move"
      end
    elsif move == "O-O"
      return game.castle_short(@color)
    elsif move == "O-O-O"
      return game.castle_long(@color)
    elsif move == "SURRENDER"
      return true
    else
      puts "Bad Input"
      return false
    end
  end

  def string_to_coords(string)
    digits = string.split(//)
    case digits[0]
    when "A"
      digits[0] = 0
    when "B"
      digits[0] = 1
    when "C"
      digits[0] = 2
    when "D"
      digits[0] = 3
    when "E"
      digits[0] = 4
    when "F"
      digits[0] = 5
    when "G"
      digits[0] = 6
    when "H"
      digits[0] = 7
    end
    return [digits[0],digits[1].to_i-1]
  end

end

