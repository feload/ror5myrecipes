require 'test_helper'

class RecipeDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name: "Panzonni", email: "panzo@italiano.com")
    @recipe = Recipe.create(name: "Wonderful pasta", description: "Wonderful pasta with a lot of sauce", chef: @chef)
  end
  
  test "should delete a recipe" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end
  
end
