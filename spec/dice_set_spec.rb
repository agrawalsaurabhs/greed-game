# frozen_string_literal: true

require_relative '../dice_set'
describe 'dice_set' do
  context 'score' do
    let(:dice_set) { DiceSet.new }
    it 'will return 0 for empty diases' do
      expect(dice_set.score([])).to be(0)
    end

    it 'test_score_of_a_single_roll_of_5_is_50' do
      expect(dice_set.score([5])).to be(50)
    end

    it 'test_score_of_a_single_roll_of_1_is_100' do
      expect(dice_set.score([1])).to be(100)
    end

    it 'test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores' do
      expect(dice_set.score([1, 5, 5, 1])).to be(300)
    end

    it 'test_score_of_single_2s_3s_4s_and_6s_are_zero' do
      expect(dice_set.score([2, 3, 4, 6])).to be(0)
    end

    it 'test_score_of_a_triple_1_is_1000' do
      expect(dice_set.score([1, 1, 1])).to be(1000)
    end

    it 'test_score_of_other_triples_is_100x' do
      expect(dice_set.score([2, 2, 2])).to be(200)
      expect(dice_set.score([3, 3, 3])).to be(300)
      expect(dice_set.score([4, 4, 4])).to be(400)
      expect(dice_set.score([5, 5, 5])).to be(500)
      expect(dice_set.score([6, 6, 6])).to be(600)
    end

    it 'test_score_of_mixed_is_sum' do
      expect(dice_set.score([2, 5, 2, 2, 3])).to be(250)
      expect(dice_set.score([5, 5, 5, 5])).to be(550)
      expect(dice_set.score([1, 1, 1, 1])).to be(1100)
      expect(dice_set.score([1, 1, 1, 1, 1])).to be(1200)
      expect(dice_set.score([1, 1, 1, 5, 1])).to be(1150)
    end
  end

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
end
