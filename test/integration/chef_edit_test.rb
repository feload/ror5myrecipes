require 'test_helper'

class ChefEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(name: "Ultramar", email: "ultra@mar.com", password: "123abc")
  end
  
  test "should reject invalid values" do
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    put chef_path(@chef), params: { chef: { name: "", email: "not_an_email", password: "" } }
    assert_template 'chefs/edit'
    assert_select 'div.alert.alert-danger'
  end
  
  test "should accept valid value" do
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    
    name = "Ultramar2"
    email = "ultramar2@mar2.com"
    put chef_path(@chef), params: { chef: { name: name, email: email, password: "1234", password_confirmation:"1234" } }
    follow_redirect!
    assert_template "chefs/show"
    assert_match name, response.body
    assert_match email, response.body
  end
  
end
