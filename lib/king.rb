class King

  attr_reader :icon, :moves, :name, :coords, :color, :first_move
  attr_writer :coords, :moves

  def initialize (coords,icon,color)
    @name = "King"
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
    up_left_path = []
    up_rigth_path = []
    down_left_path = []
    down_rigth_path = []
    up_path = []
    rigth_path = []
    left_path = []
    down_path = []

    #Right
    next_possition = [@coords[0]+1, @coords[1]]
    rigth_path.push(next_possition) unless illegal_move?(next_possition)
    #Up & Rigth
    next_possition = [@coords[0]+1, @coords[1]+1]
    up_rigth_path.push(next_possition) unless illegal_move?(next_possition)
    #Up
    next_possition = [@coords[0], @coords[1]+1]
    up_path.push(next_possition) unless illegal_move?(next_possition)
    #Up & Left
    next_possition = [@coords[0]-1, @coords[1]+1]
    up_left_path.push(next_possition) unless illegal_move?(next_possition)
    #Left
    next_possition = [@coords[0]-1, @coords[1]]
    left_path.push(next_possition) unless illegal_move?(next_possition)
    #Down & Left
    next_possition = [@coords[0]-1, @coords[1]-1]
    down_left_path.push(next_possition) unless illegal_move?(next_possition)
    #Down
    next_possition = [@coords[0], @coords[1]-1]
    down_path.push(next_possition) unless illegal_move?(next_possition)
    #Down & Right
    next_possition = [@coords[0]+1, @coords[1]-1]
    down_rigth_path.push(next_possition) unless illegal_move?(next_possition)

    possible_moves.push(up_left_path) unless up_left_path.empty?
    possible_moves.push(up_rigth_path) unless up_rigth_path.empty?
    possible_moves.push(down_left_path) unless down_left_path.empty?
    possible_moves.push(down_rigth_path) unless down_rigth_path.empty?
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