require_relative 'lib/game.rb'
require_relative 'lib/player.rb'
require 'pry'
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

moves = File.open("moves.txt")
game = Game.new
white_player = Player.new("Garry", "White")
black_player = Player.new("Carlsen", "Black")

puts "Welcome to Ruby Chess!"
puts "How to play:"
puts "Move your pieces by typing the square the piece is at followed by the square you want to move the piece to. eg: e2e4."
puts "Enter o-o if you want to do a short castle or o-o-o for a long castle."
puts "To surrender just enter 'surrender'"
puts "Good luck!"

game.board.print_board

while true    #MANUAL
  print "White player turn: "
  move = gets.chomp.upcase
  while !white_player.make_move(game,move)
    move = gets.chomp.upcase
  end
  if move == "SURRENDER"
    puts "White player surrender."
    break
  elsif game.black_king.coords == nil
    puts "White player wins."
    break
  # elsif game.black_in_checkmate?
    puts "White player wins"
    break
  end
  puts ""
  puts ""
  print "Black player turn: "
  move = gets.chomp.upcase
  while !black_player.make_move(game,move)
    move = gets.chomp.upcase
  end
  if move == "SURRENDER"
    puts "Black player surrender."
    break
  elsif game.white_king.coords == nil
    puts "Black player wins."
    break
  # elsif game.white_in_checkmate?
    puts "Black player wins."
    break
  end
  puts ""
  puts ""
end

# while true    #TEXTO
#   print "White player turn: "
#   move = moves.readline.chomp.upcase
#   while !white_player.make_move(game,move)
#     move = moves.readline.chomp.upcase
#   end
#   if move == "SURRENDER"
#     puts "White player surrender."
#     break
#   elsif game.black_king.coords == nil
#     puts "White player wins."
#     break
#   # elsif game.black_in_checkmate?
#   #   puts "White player wins"
#   #   break
#   end
#   break if moves.eof
#   puts ""
#   puts ""
#   print "Black player turn: "
#   move = moves.readline.chomp.upcase
#   while !black_player.make_move(game,move)
#     move = moves.readline.chomp.upcase
#   end
#   if move == "SURRENDER"
#     puts "Black player surrender."
#     break
#   elsif game.white_king.coords == nil
#     puts "Black player wins."
#     break
#   # elsif game.white_in_checkmate?
#   #   puts "Black player wins."
#   #   break
#   end
#   break if moves.eof
#   puts ""
#   puts ""
# end
# binding.pry
moves.close

