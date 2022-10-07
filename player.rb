# frozen_string_literal: true

class Player
  attr_reader :id
  attr_accessor :score

  def initialize(id)
    @id = id
    @score = 0
  end

  def roll_dice(number_dices, dice_set)
    dice_set.roll(number_dices)
    puts "Player #{@id} rolls: #{dice_set.values.join(', ')}"
    dice_set.score(dice_set.values)
  end
end
