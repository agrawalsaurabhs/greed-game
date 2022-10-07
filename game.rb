require_relative "dice_set"
require_relative "player"

class Game
    NUMBER_OF_DICE = 5
	ELIGIBILITY_SCORE  = 300
	MIN_WINNING_SCORE = 3000

    def initialize(num_players, dice_set)
        @players = []
        @turn =1
        @dice_set = dice_set
        for i in 1..num_players
            player = Player.new(i)
            @players.unshift(player)
        end
    end

    private
    def show_current_turn_message(current_player, last_round)
        if(current_player==1)
            puts "Turn #{@turn}:"
            puts "last round" if last_round
            puts "______"
            @turn +=1
        end
    end

    private def displpay_score(current_roll_score, current_turn_score,total_score)
        puts "Score in this round: #{current_roll_score}"
        puts "Total score: #{total_score + current_turn_score  }"
    end

    private def handle_invalid_input(continue_rolling)
        if !(continue_rolling.downcase=="y" || continue_rolling.downcase=="n")
            begin
                raise ArgumentError, "invalid input,exiting!"
            rescue ArgumentError => e
                puts e.message
                exit
            end
        end
    end

    public
    def play_game
        last_round = false
        current_turn_score=0

        while true do
            current_player = @players.pop
            show_current_turn_message(current_player.id, last_round)
            
            current_roll_score = current_player.roll_dice(NUMBER_OF_DICE,@dice_set)
            current_turn_score +=  current_roll_score
            displpay_score(current_roll_score, current_turn_score,current_player.score)
            
           
            non_scoring_dice = @dice_set.non_scoring_dice(@dice_set.values)

            loop do
                if non_scoring_dice > 0
                    puts "Do you want to roll the non scoring #{non_scoring_dice} dice? (y/n)"
                    continue_rolling = gets.chomp
                    handle_invalid_input(continue_rolling)
                    if continue_rolling == "y"
                        current_roll_score = current_player.roll_dice(non_scoring_dice,@dice_set)
                        current_turn_score = current_roll_score == 0 ? 0 : current_turn_score +=  current_roll_score
                        displpay_score(current_roll_score, current_turn_score,current_player.score)
                        
                        #calculate non scoring dice count again, break if last roll score is 0
                        current_roll_non_scoring_dice_count = @dice_set.non_scoring_dice(@dice_set.values)
                        non_scoring_dice =  current_roll_non_scoring_dice_count == non_scoring_dice ? NUMBER_OF_DICE : current_roll_non_scoring_dice_count
                        continue_rolling = "n" if current_roll_score ==0
                    end
                end
            break if continue_rolling == "n" || non_scoring_dice==0 
            end

            if(current_player.score != 0 || current_turn_score>=ELIGIBILITY_SCORE)
                current_player.score+= current_turn_score
            end

            #add current players into players array once the turn is over
            @players.unshift(current_player)

            #if it's last round and current player is last player then break 
            if last_round && current_player.id == @players.size
                break
            end

            #check for the last round 
            if current_player.id == @players.size && @players.find { |p| p.score >=MIN_WINNING_SCORE } 
                last_round = true
            end

            current_turn_score=0
            puts
        end
    end

    def end_game
        #todo: what if 2 players scores same, we need to declare multiple winners
        size = @players.size
        @players.sort_by! { |obj| obj.score}
        puts "game is over, and the winner is player #{@players[size-1].id} with score #{@players[size-1].score}"
    end
end

