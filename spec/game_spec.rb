require_relative '../game'
describe 'game' do
    before(:all) do
        
    end
    
    context "with no parameters" do	
            it "needs one argument to initialize" do
                expect { Game.new }.to raise_error(ArgumentError)
            end
    end

    context "with valid parameters" do
        it "iniaitilizes correct number of players in player array with initial score as 0 and turn as 1" do
            dice_set = DiceSet.new
            game = Game.new(3, dice_set)
            expect(game.players.length).to eq(3)
            expect(game.players[0].score).to eq(0)
            expect(game.players[1].score).to eq(0)
            expect(game.players[2].score).to eq(0)
            expect(game.turn).to eq(1)
        end

        it "should move to next player if player presses n" do
            dice_set = DiceSet.new
            game = Game.new(2, dice_set)
            game.stub(:gets).and_return("n\n","a\n")
            expect(game.players[0].id).to eq(2)            
        end
        it "should not move to next player if player presses y" do
            dice_set = DiceSet.new
            game = Game.new(2, dice_set)
            game.stub(:gets).and_return("n\n","y\n","a\n")
            expect(game.players[0].id).to eq(2)            
        end

        it "should only end the game if any of the player crosses 3000 points" do
            dice_set = DiceSet.new
            game = Game.new(2, dice_set)
            game.stub(:gets).and_return("n\n")
            game.play_game
            game.end_game
            size = game.players.size
            puts game.players.inspect
            expect(game.players[size - 1].score).to be >=3000            
        end


    end
end
