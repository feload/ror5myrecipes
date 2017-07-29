require 'test_helper'

class RecipeEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name: "Lorenzini", email: "loren@zinni.com", password: "123", password_confirmation: "123")
    @recipe = Recipe.create!(name: "Pasta al triple burro", description: "Tasty pasta with sweet sauce.", chef: @chef)
  end
  
  test "rejects invalid recipe data" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    assert_no_difference 'Recipe.count' do
      put recipe_path(@recipe), params: { recipe: { name: "", description: "" } }
    end
    assert_template 'recipes/edit'
    assert_select 'div.alert.alert-danger'
  end
  
  test "accepts valid recipe data" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    new_name = "A new name for this recipe."
    new_description = "A new description for this recipe."
    put recipe_path(@recipe), params: { recipe: { name: new_name, description: new_description } }
    # Alternative.
    # follow_redirect! 
    assert_redirected_to recipe_path(@recipe)
    assert_not flash.empty?
    @recipe.reload
    assert_match new_name, @recipe.name
    assert_match new_description, @recipe.description
  end

end
