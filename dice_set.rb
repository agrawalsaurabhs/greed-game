class DiceSet
    attr_reader :values
    def roll(num_dice)
      result = []
      num_dice.times { result << rand(1..6)}
      @values = result
    end

    def score(dice)
        if dice.length > 5
            raise ArgumentError "More than 5 dices rolled"
        end
        
        numbers_count = Hash.new(0)
        dice.each { |n| 
            if (n.is_a? Integer) && n>=1 && n<=6
            numbers_count[n]+=1 
            else
            raise ArgumentError "value must be an integer"
            break
            end
        }
        score = 0
        numbers_count.each { |k,v|
            if(v>=3) 
            v= v-3
            score += 1000 if k ==1 
            score += k * 100 if k !=1 
            end
            score += 100*v if k ==1 
            score += 50*v if k ==5
        }
        
        return score
end
end