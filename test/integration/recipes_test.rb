require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(name: "Joaquín", email: "joaq@gmail.com")
    @recipe = Recipe.create(name: "Huevos al gusto", description: "Delicious huevos", chef: @chef)
    @recipe2 = Recipe.create(name: "Grilled steak", description: "Delicious Steak", chef: @chef)
  end
  
  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
end
