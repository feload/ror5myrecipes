require 'test_helper'

class ChefShowTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(name: "Ultramar", email: "ultra@mar.com", password: "123abc")
  end
  
  test "should show an specif chef" do
    get chef_path(@chef)
    assert_template "chefs/show"
    assert_match @chef.name, response.body
    assert_match @chef.email, response.body
  end
end
