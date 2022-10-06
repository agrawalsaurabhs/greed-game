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
      
        last_round = false
        while true do
            #roll the dice for next player
            puts "rolling the dice for player #{@current_player} with #{@num_dice} dices"
            current_turn_score=0
            @dice_set.roll(@num_dice)
            puts @dice_set.values
            current_turn_score +=  @dice_set.score(@dice_set.values)

            non_scoring_dice = @dice_set.non_scoring_dice

            loop do
                if non_scoring_dice > 0
                    #give the player an option to roll again
                    
                        puts "do you want to continue? Press(y/n)"
                        continue_rolling = gets.chomp
                        #if player continues, roll the dice again
                        if continue_rolling.downcase == "y"
                            puts "rolling the dice for player #{@current_player} with #{non_scoring_dice} dices"
                            @dice_set.roll(non_scoring_dice)
                            puts @dice_set.values
                            current_roll_non_scoring_dice_count = @dice_set.non_scoring_dice
                            non_scoring_dice =  current_roll_non_scoring_dice_count == non_scoring_dice ? 5 : current_roll_non_scoring_dice_count
                            current_roll_score = @dice_set.score(@dice_set.values)
                            current_turn_score = current_roll_score ==0 ? 0 : current_turn_score +=  current_roll_score
                            continue_rolling = "n" if current_roll_score ==0
                        end
                end
            break if continue_rolling.downcase == "n" || non_scoring_dice==0 
            end

            #if it's last round and last player has 
            if last_round && @current_player == @players.size
                break
            end

            #check for the last round 
            if @current_player == @players.size && @players.find { |p| p.score >=500 } 
                last_round = true
            end

            #move to the next player
            puts "moving to the next player, current leaderboard"
            @players.each { |p| puts p.score } 
            current_player = @players.find { |p| p.id == @current_player}

            if(current_player.score != 0 || current_turn_score>=300)
                current_player.score+= current_turn_score
            end
           
            @current_player = @current_player + 1 <= @players.size ? @current_player + 1 : 1
            @num_dice = 5
        end
    end

    def end_game
        @players.sort_by { |obj| obj.score}
        puts "game is over, and the winner is #{@players[0].id} with score #{@players[0].score}"
    end
end

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
game.play
game.end_game






# dice_set = DiceSet.new
# dice_set.roll(5)
# puts dice_set.values

# player = Player.new(1,0)
# puts player.id
# puts player.score






