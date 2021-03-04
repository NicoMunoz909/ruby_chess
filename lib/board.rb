require_relative 'bishop.rb'
require_relative 'king.rb'
require_relative 'knigth.rb'
require_relative 'pawn.rb'
require_relative 'queen.rb'
require_relative 'tower.rb'

class Board

  attr_reader :cells

  def initialize(pieces)
    default_icons = squares_icons()
    @cells = [0,1,2,3,4,5,6,7].repeated_permutation(2).to_a.collect.with_index {|coords, i|
      for j in 0...pieces.length
        if pieces[j].coords == coords
          value = pieces[j]
          break
        else
          value = nil
        end
      end
      Cell.new(coords,default_icons[i],value)
    }
  end

  def print_board
    puts "8 #{@cells[7]} #{@cells[15]} #{@cells[23]} #{@cells[31]} #{@cells[39]} #{@cells[47]} #{@cells[55]} #{@cells[63]}"
    puts "7 #{@cells[6]} #{@cells[14]} #{@cells[22]} #{@cells[30]} #{@cells[38]} #{@cells[46]} #{@cells[54]} #{@cells[62]}"
    puts "6 #{@cells[5]} #{@cells[13]} #{@cells[21]} #{@cells[29]} #{@cells[37]} #{@cells[45]} #{@cells[53]} #{@cells[61]}"
    puts "5 #{@cells[4]} #{@cells[12]} #{@cells[20]} #{@cells[28]} #{@cells[36]} #{@cells[44]} #{@cells[52]} #{@cells[60]}"
    puts "4 #{@cells[3]} #{@cells[11]} #{@cells[19]} #{@cells[27]} #{@cells[35]} #{@cells[43]} #{@cells[51]} #{@cells[59]}"
    puts "3 #{@cells[2]} #{@cells[10]} #{@cells[18]} #{@cells[26]} #{@cells[34]} #{@cells[42]} #{@cells[50]} #{@cells[58]}"
    puts "2 #{@cells[1]} #{@cells[9]} #{@cells[17]} #{@cells[25]} #{@cells[33]} #{@cells[41]} #{@cells[49]} #{@cells[57]}"
    puts "1 #{@cells[0]} #{@cells[8]} #{@cells[16]} #{@cells[24]} #{@cells[32]} #{@cells[40]} #{@cells[48]} #{@cells[56]}"
    puts "  A B C D E F G H"
  end

  def squares_icons
    black_square = "\e[#{30}m\u25A0\e[0m"
    white_square = "\u25A0"
    icons = Array.new(64)
    for i in [0,16,32,48]
      for j in 0..7
        icons[i+j] = black_square if j.even?
        icons[i+j] = white_square if j.odd?
      end
    end
    for i in [8,24,40,56]
      for j in 0..7
        icons[i+j] = black_square if j.odd?
        icons[i+j] = white_square if j.even?
      end
    end
    return icons
  end

  def cell(coords)
    for i in 0...@cells.length
      if coords == @cells[i].coords
        return @cells[i]
      end
    end
    return nil
  end

  # def cell(x,y)
  #   for i in 0...@cells.length
  #     if x == @cells[i].coords[0] && y == @cells[i].coords[1]
  #       return @cells[i]
  #     end
  #   end
  #   return nil
  # end

end

class Cell < Board

  attr_reader :coords
  attr_accessor :value, :icon, :default_icon

  def initialize(coords, default_icon, value)
    @coords = coords
    @default_icon = default_icon
    @value = value
    get_icon()
  end

  def get_icon
    @icon = @default_icon if @value == nil
    @icon = @value.icon if @value != nil
  end

  def to_s
    return "#{@icon}"
  end

end



def print_board1
  black_pawn = "\e[#{30}m\u265F\e[0m"
  black_tower = "\e[#{30}m\u265C\e[0m"
  black_knigth = "\e[#{30}m\u265E\e[0m"
  black_bishop = "\e[#{30}m\u265D\e[0m"
  black_queen = "\e[#{30}m\u265B\e[0m"
  black_king = "\e[#{30}m\u265A\e[0m"
  white_pawn = "\u265F"
  white_tower = "\u265C"
  white_knigth = "\u265E"
  white_bishop = "\u265D"
  white_queen = "\u265B"
  white_king = "\u265A"
  black_square = "\e[#{30}m\u25A0\e[0m"
  white_square = "\u25A0"
  puts "8 "+black_tower+" "+black_knigth+" "+black_bishop+" "+black_queen+" "+black_king+" "+black_bishop+" "+black_knigth+" "+black_tower
  puts "7 "+(black_pawn+" ")*8
  puts "6 "+"#{white_square} #{black_square} "*4
  puts "5 "+"#{black_square} #{white_square} "*4
  puts "4 "+"#{white_square} #{black_square} "*4
  puts "3 "+"#{black_square} #{white_square} "*4
  puts "2 "+(white_pawn+" ")*8
  puts "1 "+white_tower+" "+white_knigth+" "+white_bishop+" "+white_queen+" "+white_king+" "+white_bishop+" "+white_knigth+" "+white_tower
  puts "  A B C D E F G H"
end
