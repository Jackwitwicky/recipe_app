require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @recipe = Recipe.new(title: "This is a title", description: "This is the description")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "title should not be blank" do
    @recipe.title = "   " * 5
    assert_not @recipe.valid?
  end

  test "description should be present" do
    @recipe.description = "   " * 5
    assert_not @recipe.valid?
  end
end
