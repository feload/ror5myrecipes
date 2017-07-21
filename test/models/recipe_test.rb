require 'test_helper'

class RecipeTest < ActionDispatch::IntegrationTest
  
  def setup
    @recipe = Recipe.new(name: "Salad", description: "Super tasty salad")
  end
  
  test "Recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "Name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  test "Description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "Description should have a minimum length" do
    @recipe.description = "Helo"
    assert_not @recipe.valid?
  end
  
  test "Description should have a maximum length" do
    @recipe.description = "Helo" * 500
    assert_not @recipe.valid?
  end
  
end
