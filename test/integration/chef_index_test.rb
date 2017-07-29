require 'test_helper'

class ChefIndexTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(name: "Lamar", email: "tunafever@tuna.com", password: "1234")
  end
  
  test "should display a list of chefs" do
    get chefs_path
    assert_template "chefs/index"
    assert_match @chef.name, response.body
    assert_match @chef.email, response.body
  end

end
