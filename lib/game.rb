require_relative 'board.rb'
require_relative 'pawn.rb'
require_relative 'king.rb'
require_relative 'queen.rb'
require_relative 'bishop.rb'
require_relative 'knigth.rb'
require_relative 'tower.rb'

class Game

  attr_reader :pieces, :board, :black_king, :white_king, :white_queen

  @@black_pawn = "\e[#{30}m\u265F\e[0m"
  @@black_tower = "\e[#{30}m\u265C\e[0m"
  @@black_knigth = "\e[#{30}m\u265E\e[0m"
  @@black_bishop = "\e[#{30}m\u265D\e[0m"
  @@black_queen = "\e[#{30}m\u265B\e[0m"
  @@black_king = "\e[#{30}m\u265A\e[0m"
  @@white_pawn = "\u265F"
  @@white_tower = "\u265C"
  @@white_knigth = "\u265E"
  @@white_bishop = "\u265D"
  @@white_queen = "\u265B"
  @@white_king = "\u265A"

  def initialize 
    @pieces = create_pieces()
    @board = Board.new(@pieces)
  end

  def create_pieces

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

    pieces = []

    @white_tower1 = Tower.new([0,0],white_tower, "White")
    pieces.push(@white_tower1)

    @white_tower2 = Tower.new([7,0],white_tower, "White")
    pieces.push(@white_tower2)
    
    @black_tower1 = Tower.new([0,7],black_tower, "Black")
    pieces.push(@black_tower1)

    @black_tower2 = Tower.new([7,7],black_tower, "Black")
    pieces.push(@black_tower2)

    @white_knigth1 = Knigth.new([1,0],white_knigth, "White")
    pieces.push(@white_knigth1)

    @white_knigth2 = Knigth.new([6,0],white_knigth, "White")
    pieces.push(@white_knigth2)

    @black_knigth1 = Knigth.new([1,7],black_knigth, "Black")
    pieces.push(@black_knigth1)

    @black_knigth2 = Knigth.new([6,7],black_knigth, "Black")
    pieces.push(@black_knigth2)

    @white_bishop1 = Bishop.new([2,0],white_bishop, "White")
    pieces.push(@white_bishop1)

    @white_bishop2 = Bishop.new([5,0],white_bishop, "White")
    pieces.push(@white_bishop2)

    @black_bishop1 = Bishop.new([2,7],black_bishop, "Black")
    pieces.push(@black_bishop1)

    @black_bishop2 = Bishop.new([5,7],black_bishop, "Black")
    pieces.push(@black_bishop2)

    @white_queen = Queen.new([3,0],white_queen, "White")
    pieces.push(@white_queen)

    @black_queen = Queen.new([3,7],black_queen, "Black")
    pieces.push(@black_queen)

    @white_king = King.new([4,0],white_king, "White")
    pieces.push(@white_king)

    @black_king = King.new([4,7],black_king, "Black")
    pieces.push(@black_king)

    @white_pawn1 = Pawn.new([0,1],white_pawn,"White")
    pieces.push(@white_pawn1)

    @white_pawn2 = Pawn.new([1,1],white_pawn,"White")
    pieces.push(@white_pawn2)

    @white_pawn3 = Pawn.new([2,1],white_pawn,"White")
    pieces.push(@white_pawn3)

    @white_pawn4 = Pawn.new([3,1],white_pawn,"White")
    pieces.push(@white_pawn4)

    @white_pawn5 = Pawn.new([4,1],white_pawn,"White")
    pieces.push(@white_pawn5)

    @white_pawn6 = Pawn.new([5,1],white_pawn,"White")
    pieces.push(@white_pawn6)

    @white_pawn7 = Pawn.new([6,1],white_pawn,"White")
    pieces.push(@white_pawn7)

    @white_pawn8 = Pawn.new([7,1],white_pawn,"White")
    pieces.push(@white_pawn8)

    @black_pawn1 = Pawn.new([0,6],black_pawn,"Black")
    pieces.push(@black_pawn1)

    @black_pawn2 = Pawn.new([1,6],black_pawn,"Black")
    pieces.push(@black_pawn2)

    @black_pawn3 = Pawn.new([2,6],black_pawn,"Black")
    pieces.push(@black_pawn3)

    @black_pawn4 = Pawn.new([3,6],black_pawn,"Black")
    pieces.push(@black_pawn4)

    @black_pawn5 = Pawn.new([4,6],black_pawn,"Black")
    pieces.push(@black_pawn5)

    @black_pawn6 = Pawn.new([5,6],black_pawn,"Black")
    pieces.push(@black_pawn6)

    @black_pawn7 = Pawn.new([6,6],black_pawn,"Black")
    pieces.push(@black_pawn7)

    @black_pawn8 = Pawn.new([7,6],black_pawn,"Black")
    pieces.push(@black_pawn8)

    return pieces
  end

  def move_piece(from,to)
    i = @pieces.find_index{|piece| piece.coords == from}
    piece = piece_at(from)

    for i in 0...@pieces.length
      if @pieces[i].name == "Pawn" && @pieces[i] != piece
        @pieces[i].en_passant = false
        @pieces[i].moves = @pieces[i].possible_moves
      end
    end

    if piece != nil
      path = check_path(from,to)
      if path.include?(to)

        if piece.color == "White" && white_in_check?()
          capture = move_helper(piece,from,to)
          if white_in_check?()
            undo_move(piece,capture,from,to)
            puts "Your King is in check, you must defend it!"
            return false
          else
            undo_move(piece,capture,from,to)
          end
        elsif piece.color == "Black" && black_in_check?()
          capture = move_helper(piece,from,to)
          if black_in_check?()
            undo_move(piece,capture,from,to)
            puts "Your King is in check, you must defend it!"
            return false
          else
            undo_move(piece,capture,from,to)
          end
        end

        if piece.color == "White"
          capture = move_helper(piece,from,to)
          if white_in_check?()
            undo_move(piece,capture,from,to)
            puts "That would leave your king in check"
            return false
          else
            undo_move(piece,capture,from,to)
          end
        elsif piece.color == "Black"
          capture = move_helper(piece,from,to)
          if black_in_check?()
            undo_move(piece,capture,from,to)
            puts "That would leave your king in check"
            return false
          else
            undo_move(piece,capture,from,to)
          end
        end

        if piece_at(to) != nil
          @pieces.delete(piece_at(to))
          piece_at(to).delete
          @board.cell(to).value = nil
        end

        if piece.name == "Pawn"

          if piece.en_passant == true && piece.moves[-1] == to
            if piece.color == "White"
              @pieces.delete(piece_at([to[0],to[1]-1]))
              piece_at([to[0],to[1]-1]).delete
              @board.cell([to[0],to[1]-1]).value = nil
              @board.cell([to[0],to[1]-1]).icon = @board.cell([to[0],to[1]-1]).default_icon
              piece.en_passant = false
            else
              @pieces.delete(piece_at([to[0],to[1]+1]))
              piece_at([to[0],to[1]+1]).delete
              @board.cell([to[0],to[1]+1]).value = nil
              @board.cell([to[0],to[1]+1]).icon = @board.cell([to[0],to[1]+1]).default_icon
              piece.en_passant = false
            end
          end

          if from[1]+2 == to[1] || from[1]-2 == to[1]
            if piece_at([to[0]+1,to[1]]) != nil && piece_at([to[0]+1,to[1]]).name == "Pawn" && piece_at([to[0]+1,to[1]]).color != piece.color
              if piece_at([to[0]+1,to[1]]).color == "White"
                piece_at([to[0]+1,to[1]]).add_en_passant([from[0],from[1]-1])
              else
                piece_at([to[0]+1,to[1]]).add_en_passant([from[0],from[1]+1])
              end
            elsif piece_at([to[0]-1,to[1]]) != nil && piece_at([to[0]-1,to[1]]).name == "Pawn" && piece_at([to[0]-1,to[1]]).color != piece.color
              if piece_at([to[0]-1,to[1]]).color == "White"
                piece_at([to[0]-1,to[1]]).add_en_passant([from[0],from[1]-1])
              else
                piece_at([to[0]-1,to[1]]).add_en_passant([from[0],from[1]+1])
              end
            end
          end

        end 

        puts "#{piece.icon} #{coords_to_string(from)} => #{coords_to_string(to)}"
        piece.move(to)

        if piece.name == "Pawn"
          if piece.color == "White" && piece.coords[1] == 7
            piece = promote_pawn(piece)
            puts piece
          elsif piece.coords[1] == 0
            piece = promote_pawn(piece)
          end
        end

        update_board(from,to,piece)
        return true
      else
        puts "#{piece.icon} #{coords_to_string(piece.coords)} can't move to #{coords_to_string(to)}"
        return false
      end
    else
      puts "There isn't a piece to move"
      return false
    end
  end

  def move_helper(piece,from,to)
    piece.coords = to
    @board.cell(from).value = nil
    if piece_at(to) != nil
      capture = piece_at(to)
      capture.delete
      @board.cell(to).value = piece
      return capture
    end
    @board.cell(to).value = piece
    return nil
  end

  def undo_move(piece,capture,from,to)
    piece.coords = to
    @board.cell(from).value = piece
    if capture != nil
      capture.coords = to
      @board.cell(to).value = capture
      return
    end
    @board.cell(to).value = nil
  end

  def stalemate?
    #if king in check?
      #yes --> return false
    #No --> Can make a move whitout getting in check?
      #yes --> return false
    #No --> Return true  
  end


  def check_path(from, to)
    piece = piece_at(from)
    if piece == nil
      return nil
    end
    #For the fucking pawns
    if piece.name == "Pawn"
      path = piece.make_path(to)
      for i in 0...path.length
        if @board.cell(path[i]).value != nil
            path = path[0...i]
            break
        end
      end

      #Add capture to pawn's move if able
      if piece.color == "White"
        up_left = [piece.coords[0]-1, piece.coords[1]+1]
        up_rigth = [piece.coords[0]+1, piece.coords[1]+1]

        if @board.cell(up_left) != nil
          if @board.cell(up_left).value != nil && @board.cell(up_left).value.color != piece.color
            path.push(up_left)
          end
        end
        if @board.cell(up_rigth) != nil
          if @board.cell(up_rigth).value != nil && @board.cell(up_rigth).value.color != piece.color
            path.push(up_rigth)
          end
        end
        return path
      else
        down_left = [piece.coords[0]-1, piece.coords[1]-1]
        down_rigth = [piece.coords[0]+1, piece.coords[1]-1]

        if @board.cell(down_left) != nil
          if @board.cell(down_left).value != nil && @board.cell(down_left).value.color != piece.color
            path.push(down_left)
          end
        end
        if @board.cell(down_rigth) != nil
          if @board.cell(down_rigth).value != nil && @board.cell(down_rigth).value.color != piece.color
            path.push(down_rigth)
          end
        end
        return path
      end

    #For not pawns in the ass pieces  
    else
      path = piece.make_path(to)
      for i in 0...path.length
        if @board.cell(path[i]).value != nil
          if @board.cell(path[i]).value.color == piece.color
            path = path[0...i]
            break
          else
            path = path[0..i]
            break
          end
        end
      end
      return path
    end
  end

  def update_moves
    moves = []
    for i in 0...pieces.length
      moves.clear
      for j in 0...pieces[i].moves.length
        if pieces[i].name == "Pawn" || pieces[i].name == "Knigth"
          moves.push(check_path(pieces[i].coords,pieces[i].moves[j]))
        else
          moves.push(check_path(pieces[i].coords,pieces[i].moves[j][-1]))
        end
      end
      pieces[i].moves = moves.flatten(1)
    end
  end

  def promote_pawn(piece)
    print "To wich piece do you want to promote your pawn? ([Q]ueen/[T]ower/[K]nigth/[B]ishop)"
    promotion = gets.chomp
    while promotion.upcase != "Q" && promotion.upcase != "T" && promotion.upcase != "K" && promotion.upcase != "B" 
      puts "Wrong input"
      promotion = gets.chomp
    end
    if piece.color == "White"
      case promotion.upcase
      when "Q"
        return Queen.new(piece.coords,@@white_queen,"White")
      when "T"
        return Tower.new(piece.coords,@@white_tower,"White")
      when "K"
        return Knigth.new(piece.coords,@@white_knigth,"White")
      when "B"
        return Bishop.new(piece.coords,@@white_bishop,"White")
      end
    else
      case promotion.upcase
      when "Q"
        return Queen.new(piece.coords,@@black_queen,"Black")
      when "T"
        return Tower.new(piece.coords,@@black_tower,"Black")
      when "K"
        return Knigth.new(piece.coords,@@black_knigth,"Black")
      when "B"
        return Bishop.new(piece.coords,@@black_bishop,"Black")
      end
    end
  end

  def update_board(from,to,piece)
    old_cell = @board.cell(from)
    new_cell = @board.cell(to)
    old_cell.value = nil
    new_cell.value = piece
    old_cell.get_icon
    new_cell.get_icon
    @board.print_board
  end

  def coords_to_string(coords)
    string = ""
  
    case coords[0]
    when 0
      string += "A"
    when 1
      string += "B"
    when 2
      string += "C"
    when 3
      string += "D"
    when 4
      string += "E"
    when 5
      string += "F"
    when 6
      string += "G"
    when 7
      string += "H"
    end
  
    string += (coords[1]+1).to_s
  end

  def piece_at(coords)
    if @board.cell(coords) != nil
      return @board.cell(coords).value
    else
      return nil
    end
  end

  def white_in_check?
    return piece_threatened?(@white_king)
  end

  def black_in_check?
    return piece_threatened?(@black_king)
  end

  def white_in_checkmate?
    if white_in_check?() #King in check?
      moves = @white_king.moves.flatten(1).collect! {|move| check_path(@white_king.coords,move)}.flatten(1)
      if !moves.all? {|move| threatened?(move,@white_king.color)} #Yes --> Can move out of check?
        return false #Yes --> No checkmate
      elsif can_capture_threats?(@white_king) #No --> Can capture all threats?
        if king_still_in_check?(@white_king) #Yes --> Would the king still be in check?
          if can_block?(@white_king) #Yes --> Can block all threats?
            return false #Yes --> No checkmate
          else
            return true #No --> Checkmate
          end
        else
          return false #No --> No checkmate
        end
      elsif can_block?(@white_king) #No --> Can block all threats?
        return false #Yes --> No checkmate
      else 
        return true #No --> Checkmate
      end
    else
      return false #No --> No checkmate
    end 
  end

  def black_in_checkmate?
    if black_in_check?() #King in check?
      moves = @black_king.moves.flatten(1).collect! {|move| check_path(@black_king.coords,move)}.flatten(1)
      if !moves.all? {|move| threatened?(move,@black_king.color)} #Yes --> Can move out of check?
        return false #Yes --> No checkmate
      elsif can_capture_threats?(@black_king) #No --> Can capture all threats?
        if king_still_in_check?(@black_king) #Yes --> Would the king still be in check?
          if can_block?(@black_king) #Yes --> Can block all threats?
            return false #Yes --> No checkmate
          else
            return true #No --> Checkmate
          end
        else
          return false #No --> No checkmate
        end
      elsif can_block?(@black_king) #No --> Can block all threats?
        return false #Yes --> No checkmate
      else 
        return true #No --> Checkmate
      end
    else
      return false #No --> No checkmate
    end   
  end

  def can_capture_threats?(king)
    path = []
    threats = []
    for i in 0...pieces.length
      if pieces[i].color != king.color
        path = check_path(pieces[i].coords,king.coords)
        if path.include?(king.coords)
          threats.push(pieces[i])
        end
      end
    end
    if threats.length > 1
      return false
    elsif piece_threatened?(threats[0])
      return true
    else
      return false
    end
  end

  def can_block?(king)
    path = []
    threats = []
    for i in 0...pieces.length
      if pieces[i].color != king.color
        path = check_path(pieces[i].coords,king.coords)
        if path.include?(king.coords)
          threats.push(pieces[i])
        end
      end
    end
    if threats.length > 1
      return false
    end
    threat = who_is_threatening?(king)[0]
    path = check_path(threat.coords,king.coords)
    for i in 0...path.length
      for j in 0...pieces.length
        if pieces[j].color != threat.color
          if check_path(pieces[j].coords, path[i]).include?(path[i])
            return true
          end
        end
      end
    end

    return false
  end

  def king_still_in_check?(king)
    threat = who_is_threatening?(king)
    defenders = who_is_threatening?(threat[0])
    checks = []
    for i in 0...defenders.length
      temp1 = threat[0].coords
      temp2 = defenders[i].coords
      checks.push(dummy_move(king,defenders[i],threat[0]))
      undo_dummy_move(threat[0],defenders[i],temp1,temp2)
    end
    if checks.all?
      return true
    else
      return false
    end
  end

  def dummy_move(king,defender,threat)
    @board.cell(threat.coords).value = defender
    defender.coords = threat.coords
    threat.coords = nil
    if king.color == "White"
      return white_in_check?
    else
      return black_in_check?
    end
  end

  def undo_dummy_move(threat,defender,temp1,temp2)
    @board.cell(temp1).value = threat
    threat.coords = temp1
    defender.coords = temp2
  end

  def who_is_threatening?(piece)
    threats = []
    path = []
    for i in 0...pieces.length
      if pieces[i].color != piece.color
        path = check_path(pieces[i].coords,piece.coords)
        if path.include?(piece.coords)
          threats.push(pieces[i])
        end
      end
    end
    return threats
  end

  def threatened?(coords,color)
    temp = @board.cell(coords).value
    if color == "White"
      king = @white_king
      @board.cell(coords).value = king
      @board.cell(king.coords).value = nil
    else
      king = @black_king
      @board.cell(coords).value = king
      @board.cell(king.coords).value = nil
    end
    path = []
    for i in 0...pieces.length
      if pieces[i].color != color
        path.push(check_path(pieces[i].coords,coords))
      end
    end
    if path.flatten(1).include?(coords)
      @board.cell(coords).value = temp
      @board.cell(king.coords).value = king
      return true
    else
      @board.cell(coords).value = temp
      @board.cell(king.coords).value = king
      return false
    end
  end

  def piece_threatened?(piece)
    path = []
    for i in 0...pieces.length
      if pieces[i].color != piece.color
        path.push(check_path(pieces[i].coords,piece.coords))
      end
    end
    if path.flatten(1).include?(piece.coords)
      return true
    else
      return false
    end
  end

  def castle_short(color)
    if color == "White"
      if white_in_check?() || threatened?([5,0],"White") || threatened?([6,0],"White") || piece_at([5,0]) !=nil || piece_at([6,0]) != nil || !@white_king.first_move || !@white_tower2.first_move
        puts "Can't castle"
        return false
      else
        puts ""
        puts ""
        @white_tower2.move([5,0])
        update_board([7,0],[5,0],@white_tower2)
        @white_king.move([6,0])
        update_board([4,0],[6,0],@white_king)
        return true
      end
    else
      if black_in_check?() || threatened?([5,7],"Black") || threatened?([6,7],"Black") || piece_at([5,7]) !=nil || piece_at([6,7]) != nil || !@black_king.first_move || !@black_tower2.first_move
        puts "Can't castle"
        return false
      else
        puts ""
        puts ""
        @black_tower2.move([5,7])
        update_board([7,7],[5,7],@black_tower2)
        @black_king.move([6,7])
        update_board([4,7],[6,7],@black_king)
      end
    end
  end

  def castle_long(color)
    if color == "White"
      if white_in_check?() || threatened?([3,0],"White") || threatened?([2,0],"White") || threatened?([1,0],"White") || piece_at([3,0]) !=nil || piece_at([2,0]) != nil || piece_at([1,0]) != nil || !@white_king.first_move || !@white_tower1.first_move
        puts "Can't castle"
        return false
      else
        @white_tower1.move([3,0])
        update_board([0,0],[3,0],@white_tower1)
        @white_king.move([2,0])
        update_board([4,0],[2,0],@white_king)
        return true
      end
    else
      if black_in_check?() || threatened?([3,7],"Black") || threatened?([2,7],"Black") || threatened?([1,7],"Black") || piece_at([3,7]) !=nil || piece_at([2,7]) != nil || piece_at([1,7]) != nil || !@black_king.first_move || !@black_tower1.first_move
        puts "Can't castle"
        return false
      else
        @black_tower1.move([3,7])
        update_board([0,7],[3,7],@black_tower1)
        @black_king.move([2,7])
        update_board([4,7],[2,7],@black_king)
        return true
      end
    end
  end

end

Game.new