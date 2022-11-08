# frozen_string_literal: true

class DiceSet
  attr_reader :values

  def score(dice)
    score = 0
    return score if dice.size.zero?

    numbers_count = build_count_hash(dice)
    numbers_count.each do |k, v|
      if v >= 3
        v -= 3
        score += 1000 if k == 1
        score += k * 100 if k != 1
      end
      score += 100 * v if k == 1
      score += 50 * v if k == 5
    end

    score
  end

  def non_scoring_dice(dice)
    count = 0
    return count if dice.size.zero?

    numbers_count = build_count_hash(dice)
    numbers_count.each do |k, v|
      v -= 3 if v >= 3
      count += v if [2, 3, 4, 6].include?(k) && v.positive?
    end
    # puts "count of non scoring dice #{count}"
    count
  end

  def roll(num_dice)
    result = []
    num_dice.times { result << rand(1..6) }
    @values = result
  end

  private

  def build_count_hash(dice)
    numbers_count = Hash.new(0)
    dice.each do |n|
      numbers_count[n] += 1
    end
    numbers_count
  end
end
