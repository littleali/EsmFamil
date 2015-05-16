require 'test_helper'

class PaperTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "paper field" do
    game = Game.new(:title => 'test3')
    assert game.save
    paper = Paper.new
    paper.game = game
    paper.save
    assert_equal(paper.paper_fields.count, game.item_names.length)
    paper.paper_fields.each do  |pf|
      assert game.item_names.include? pf.name
    end
    paper.destroy
    game.destroy
  end

end
