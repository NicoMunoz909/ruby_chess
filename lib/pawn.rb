class Pawn

  attr_accessor :coords, :en_passant, :moves
  attr_reader :icon, :name, :color

  def initialize (coords,icon,color)
    @name = "Pawn"
    @first_move = true
    @en_passant = false
    @coords = coords
    @icon = icon
    @color = color
    @moves = possible_moves()
  end

  def move(to)
    @first_move = false
    @coords = to
    @moves = possible_moves()
  end

  def possible_moves()
    possible_moves = []

    if @color == "White"
      next_possition = [@coords[0], @coords[1]+1]
      possible_moves.push(next_possition) unless illegal_move?(next_possition)

      #For first move
      next_possition = [@coords[0], @coords[1]+2]
      possible_moves.push(next_possition) if @first_move
    end

    if @color == "Black"
      next_possition = [@coords[0], @coords[1]-1]
      possible_moves.push(next_possition) unless illegal_move?(next_possition)

      #For first move
      next_possition = [@coords[0], @coords[1]-2]
      possible_moves.push(next_possition) if @first_move
    end
    
    # #Capture to the right
    # if capture_rigth
    #   next_possition = [@coords[0]+1, @coords[1]+1]
    #   possible_moves.push(next_possition) unless illegal_move?(next_possition)
    # end

    # #Capture to the left
    # if capture_left
    #   next_possition = [@coords[0]-1, @coords[1]+1]
    #   possible_moves.push(next_possition) unless illegal_move?(next_possition)
    # end

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

  def add_en_passant(coords)
    @en_passant = true
    @moves.push(coords)
  end

end