require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(name: "Joaquín", email: "joaq@gmail.com", password: "123", password_confirmation: "123")
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
    assert_select "a[href=?]", recipe_path(@recipe), @recipe.name
    assert_match @recipe2.name, response.body
    assert_select "a[href=?]", recipe_path(@recipe2), @recipe2.name
  end
  
  test "should get recipes show" do
    get recipe_path @recipe
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.name, response.body
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text: "Edit"
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete"
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
