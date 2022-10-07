require_relative "../dice_set"
describe "dice_set" do
    context "score" do
      let(:dice_set) {DiceSet.new}
      it "will return 0 for empty diases" do
        score = dice_set.score([])
        expect(score).to be(0)
      end

      it "test_score_of_a_single_roll_of_5_is_50" do
        score = dice_set.score([5])
        expect(score).to be(50)
      end
    end
   
    # context "in another context" do
    #   it "does another thing" do
    #     #Some logic
    #     #some assertions eg. expect(a).to be(b)
    #   end
    # end
  end