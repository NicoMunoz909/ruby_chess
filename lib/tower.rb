class Tower

  attr_reader :icon, :moves, :coords, :name, :color, :first_move
  attr_writer :coords, :moves

  def initialize (coords,icon,color)
    @name = "Tower"
    @coords = coords
    @icon = icon
    @color = color
    @moves = possible_moves()
    @first_move = true
  end

  def move(to)
    @coords = to
    @moves = possible_moves()
    @first_move = false
  end

  def possible_moves
    possible_moves = []
    up_path = []
    rigth_path = []
    left_path = []
    down_path = []
    for i in 1..7
      #Up
      next_possition = [@coords[0], @coords[1]+i]
      up_path.push(next_possition) unless illegal_move?(next_possition)
    end
    for i in 1..7
      #Right
      next_possition = [@coords[0]+i, @coords[1]]
      rigth_path.push(next_possition) unless illegal_move?(next_possition)
    end
    for i in 1..7
      #Left
      next_possition = [@coords[0]-i, @coords[1]]
      left_path.push(next_possition) unless illegal_move?(next_possition)
    end
    for i in 1..7
      #Down
      next_possition = [@coords[0], @coords[1]-i]
      down_path.push(next_possition) unless illegal_move?(next_possition)
    end
    possible_moves.push(up_path) unless up_path.empty?
    possible_moves.push(rigth_path) unless rigth_path.empty?
    possible_moves.push(down_path) unless down_path.empty?
    possible_moves.push(left_path) unless left_path.empty?
    return possible_moves
  end

  def make_path(to)
    path = @moves.filter {|path| path.include?(to)}.flatten(1)
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