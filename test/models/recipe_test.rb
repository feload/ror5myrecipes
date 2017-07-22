require 'test_helper'

class RecipeTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(name: "Emiliana", email: "emiliana@hellkitchen.com")
    @recipe = Recipe.new(name: "Salad", description: "Super tasty salad", chef_id: @chef.id)
  end
  
  test "Recipe should be valid" do
    assert @recipe.valid?, @recipe.errors.full_messages
  end
  
  test "Recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
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
  
  test "create new valid recipe" do
    get new_recipe_path
    recipe_name =  "This is a new recipe!"
    recipe_description = "Supeer duuper recipe for testing"
    assert_template 'recipes/new'
    assert_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { name: recipe_name, description: recipe_description } }
    end
    follow_redirect!  # This one is required when using "redirect_to" method.
    assert_match recipe_name, response.body
    assert_match recipe_description, response.body
  end
  
  test "reject invalid recipe submission" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { name: "", description: "" } }
    end
    assert_template 'recipes/new'
    assert_select 'div.alert.alert-danger'
  end
  
end
