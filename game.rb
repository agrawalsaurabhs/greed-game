require_relative "dice_set"
require_relative "player"

class Game
    NUMBER_OF_DICE = 5
	ELIGIBILITY_SCORE  = 300
	MIN_WINNING_SCORE = 3000

    def initialize(num_players, dice_set)
        @players = []
        @dice_set = dice_set
        for i in 1..num_players
            player = Player.new(i)
            @players.push(player)
        end
    end

    # private
    # def show_message(current_player, turn)
    #     if(current_player==1)
    #         puts "Turn #{turn}:"
    #         puts "______"
    #         turn +=1
    #     end
    # end

    public
    def play_game
      
        last_round = false
        turn =1
        current_turn_score=0
        current_player=1
        
        while true do
            #show below message at the start of each turn i.e. when player 1's turn comes up
            if(current_player==1)
                puts "Turn #{turn}:"
                puts "______"
                turn +=1
            end
            current_player_obj = @players.find { |p| p.id == current_player}
            @dice_set.roll(NUMBER_OF_DICE)
            puts "Player #{current_player} rolls: #{@dice_set.values.join(", ")}"
            current_turn_score +=  @dice_set.score(@dice_set.values)
            puts "Score in this round: #{current_turn_score}"
            puts "Total score: #{current_player_obj.score + current_turn_score }"
            non_scoring_dice = @dice_set.non_scoring_dice

            loop do
                if non_scoring_dice > 0
                    #give the player an option to roll again
                    puts "Do you want to roll the non scoring #{non_scoring_dice} dice? (y/n)"
                    continue_rolling = gets.chomp
                    
                    if !(continue_rolling.downcase=="y" || continue_rolling.downcase=="n")
                        begin
                            raise ArgumentError, "invalid input,exiting!"
                        rescue ArgumentError => e
                            puts e.message
                            exit
                        end
                    end
                    #if player continues, roll the dice again
                    if continue_rolling == "y"
                        
                        @dice_set.roll(non_scoring_dice)
                        puts "Player #{current_player} rolls: #{@dice_set.values.join(", ")}"
                        
                        current_roll_non_scoring_dice_count = @dice_set.non_scoring_dice
                        non_scoring_dice =  current_roll_non_scoring_dice_count == non_scoring_dice ? 5 : current_roll_non_scoring_dice_count
                        current_roll_score = @dice_set.score(@dice_set.values)
                        puts "Score in this round: #{current_roll_score}"
                        current_turn_score = current_roll_score ==0 ? 0 : current_turn_score +=  current_roll_score
                        puts "Total score: #{current_player_obj.score + current_turn_score }"
                        continue_rolling = "n" if current_roll_score ==0
                    end
                end
            break if continue_rolling == "n" || non_scoring_dice==0 
            end

            #if it's last round and last player has 
            if last_round && current_player == @players.size
                break
            end

            #check for the last round 
            if current_player == @players.size && @players.find { |p| p.score >=500 } 
                last_round = true
            end

            #move to the next player
            
             
            current_player_obj = @players.find { |p| p.id == current_player}

            if(current_player_obj.score != 0 || current_turn_score>=300)
                current_player_obj.score+= current_turn_score
            end
            
            current_player = current_player + 1 <= @players.size ? current_player + 1 : 1
            current_turn_score=0
            puts
        end
    end

    def end_game
        @players.sort_by { |obj| obj.score}
        puts "game is over, and the winner is player #{@players[0].id} with score #{@players[0].score}"
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
game.play_game
game.end_game













