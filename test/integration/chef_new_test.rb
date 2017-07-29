require 'test_helper'

class ChefNewTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(name: "Lorenzo", email: "lorenzo@taste.com", password: "1234")
  end
  
  test "must show the form" do
    get new_chef_path
    assert_template "chefs/new"
  end
  
  test "must show error when invalid date is sent" do
    get new_chef_path
    assert_template 'chefs/new'
    assert_no_difference 'Chef.count' do
      post chefs_path, params: { chef: { name: "", email: "", password: "12", password_confirmation: "1" } }
    end
    assert_template 'chefs/new'
    assert_select 'div.alert.alert-danger'
  end
  
  test "must confirm chef creation" do
    get new_chef_path
    assert_template "chefs/new"
    assert_difference "Chef.count" do
      post chefs_path, params: { chef: { name: "Florentina", email: "flore@ntina.com", password: "1234", password_confirmation:"1234" } }
    end
  end
  
end
