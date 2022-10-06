require_relative "dice_set"
require_relative "player"

class Game
    
    def initialize(num_players)
        @players = []
        for i in 1..num_players
            player = Player.new(i)
            @players.push(player)
        end
        @players.each { |p| puts p.id } 
    end
end

print "Welcome to Greed Game, Enter number of players (e.g. 3):"
begin
    num_players = Integer(gets.chomp)
rescue
    puts "please enter integer values greater than 1"
end
game = Game.new(num_players)





# dice_set = DiceSet.new
# dice_set.roll(5)
# puts dice_set.values

# player = Player.new(1,0)
# puts player.id
# puts player.score






