require 'test_helper'

class RecipeTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(name: "Emiliana", email: "emiliana@hellkitchen.com", password: "123", password_confirmation: "123")
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
  
end
