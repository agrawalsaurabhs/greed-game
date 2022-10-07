class DiceSet
    attr_reader :values
    private 
    attr_reader :numbers_count

    
    private def build_count_hash
        @numbers_count = Hash.new(0)
        @values.each { |n| 
            @numbers_count[n]+=1 
        }
    end

    public def roll(num_dice)
      result = []
      num_dice.times { result << rand(1..6)}
      @values = result
      build_count_hash

    end

    public def non_scoring_dice
        count =0
        @numbers_count.each { |k,v|
            if(v>=3) 
                v= v-3
            end
            count += v if (k == 2 || k == 3 || k==4 || k==6) && v>0
        }
        # puts "count of non scoring dice #{count}"     
        return count
    end

    public def score(dice)
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