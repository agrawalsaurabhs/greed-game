require_relative "game"
require_relative "dice_set"

print "Welcome to Greed Game!! Enter the number of players (e.g. 3):"
begin
    num_players = Integer(gets.chomp)
rescue
    puts "please enter integer values between 2 and 10"
    exit
end

if num_players<2 || num_players >10
    begin
        raise ArgumentError, "number of players should be between 2 and 10"
    rescue ArgumentError => e
        puts e.message
        exit
    end
end

dice_set = DiceSet.new
game = Game.new(num_players, dice_set)
game.play_game
game.end_game