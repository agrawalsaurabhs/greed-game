# frozen_string_literal: true

require_relative '../dice_set'
describe 'dice_set' do
  context 'roll the dice' do
    let(:dice_set) { DiceSet.new }

    it 'should return empty values for 0 number of dices' do
      expect(dice_set.roll(0).size).to be(0)
    end

    it 'should return same number of dice values as number of dices passed' do
      expect(dice_set.roll(5).size).to be(5)
    end

    it 'should return dice value between 1 and 6' do
      expect(dice_set.roll(5)).to all(be >= 1)
      expect(dice_set.roll(5)).to all(be <= 6)
    end
  end

  context 'non_scoring_dice' do
    let(:dice_set) { DiceSet.new }

    it 'should return 0 for 0 number of dices' do
      expect(dice_set.non_scoring_dice([])).to be(0)
    end

    it 'should return 2 when all dice values are non scoring' do
      expect(dice_set.non_scoring_dice([2, 2, 2, 2, 2])).to be(2)
    end

    it 'should return 0 when all dice values are scoring' do
      expect(dice_set.non_scoring_dice([1, 1, 1, 1, 1])).to be(0)
    end
  end
  context 'score' do
    let(:dice_set) { DiceSet.new }
    it 'will return 0 for empty diases' do
      expect(dice_set.score([])).to be(0)
    end

    it 'should return 50 for a single dice of value 5' do
      expect(dice_set.score([5])).to be(50)
    end

    it 'should return 100 for a single dice of value 1' do
      expect(dice_set.score([1])).to be(100)
    end

    it 'should return 300 for pair of 1 and 5' do
      expect(dice_set.score([1, 5, 5, 1])).to be(300)
    end

    it 'should return 0 for non scoring dice' do
      expect(dice_set.score([2, 3, 4, 6])).to be(0)
    end

    it 'shoudl return 1000 for triplet for 1' do
      expect(dice_set.score([1, 1, 1])).to be(1000)
    end

    it 'should return 100*number for respective triplets of numbers' do
      expect(dice_set.score([2, 2, 2])).to be(200)
      expect(dice_set.score([3, 3, 3])).to be(300)
      expect(dice_set.score([4, 4, 4])).to be(400)
      expect(dice_set.score([5, 5, 5])).to be(500)
      expect(dice_set.score([6, 6, 6])).to be(600)
    end

    it 'should return score correctly for different combination of scoring and non scoring dices' do
      expect(dice_set.score([2, 5, 2, 2, 3])).to be(250)
      expect(dice_set.score([5, 5, 5, 5])).to be(550)
      expect(dice_set.score([1, 1, 1, 1])).to be(1100)
      expect(dice_set.score([1, 1, 1, 1, 1])).to be(1200)
      expect(dice_set.score([1, 1, 1, 5, 1])).to be(1150)
    end
  end
end
