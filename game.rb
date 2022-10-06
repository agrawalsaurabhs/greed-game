require_relative "dice_set"
require_relative "player"

class Game
    
    def initialize(num_players, dice_set)
        @players = []
        @current_player = 1
        @num_dice = 5
        @dice_set = dice_set
        for i in 1..num_players
            player = Player.new(i)
            @players.push(player)
        end
        
        @players.each { |p| puts p.id } 
        puts @players.size
    end

    def start_game
        puts "game is getting, please wait for your turn"
    end

    def play
        #roll the dice for next player
        puts "rolling the dice for player #{@current_player}"
        @dice_set.roll(@num_dice)
        puts @dice_set.values


        #set the next player 
        @current_player = @current_player + 1 <= @players.size ? @current_player + 1 : 1
        @num_dice = 5
        

    end

    def end_game
        @players.sort_by { |obj| obj.score}
        puts "game is over, and the winner is #{@players[0]}"
    end
end

print "Welcome to Greed Game, Enter number of players (e.g. 3):"
begin
    num_players = Integer(gets.chomp)
rescue
    puts "please enter integer values greater than 1"
end
dice_set = DiceSet.new
game = Game.new(num_players, dice_set)
game.play
game.play
game.play
game.play
game.play
game.play





# dice_set = DiceSet.new
# dice_set.roll(5)
# puts dice_set.values

# player = Player.new(1,0)
# puts player.id
# puts player.score






