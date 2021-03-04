class Knigth

  attr_reader :icon, :moves, :coords, :name, :color
  attr_writer :coords, :moves

  def initialize (coords,icon,color)
    @name = "Knigth"
    @coords = coords
    @icon = icon
    @color = color
    @moves = possible_moves()
  end

  def move(to)
    @coords = to
    @moves = possible_moves()
  end

  def possible_moves
    possible_moves = []

    moves = [[1,2], [1,-2], [2,1], [2,-1], [-1,2], [-1,-2], [-2,-1], [-2,1]]
    possible_moves = []
    moves.each {|move|
      next_position = [@coords[0]+move[0], @coords[1]+move[1]]
      possible_moves.push(next_position)  unless illegal_move?(next_position)
    }
    
    return possible_moves
  end

  def make_path(to)
    path = []
    i = @moves.find_index {|move| move == to}
    path.push(@moves.at(i)) unless i == nil
    return path
  end

  def illegal_move?(cell)
    if cell[0] < 0 || cell[0] > 7 || cell[1] < 0 || cell[1] > 7
      return true
    else 
      return false
    end
  end

  def to_s
    return "#{@icon} #{@coords}"
  end

  def delete
    @coords = nil
  end
end