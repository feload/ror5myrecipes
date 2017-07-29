require 'test_helper'

class ChefTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.new(name: "Felipe", email: "felipe@bestchefs.com", password: "123", password_confirmation: "123")
  end
  
  test "should be valid" do
    assert @chef.valid?
  end
  
  test "name should be present" do
    @chef.name = ""
    assert_not @chef.valid?
  end
  
  test "name should not be more than 40 chars" do
    @chef.name = "a" * 41
    assert_not @chef.valid?
  end
  
  test "email should be present" do
    assert @chef.valid?
  end
  
  test "email should be valid" do
    @chef.email = "anything_not_an_email"
    assert_not @chef.valid?
  end
  
  test "email should be unique" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  
  test "email should be lower case before hitting db" do
    mixed_email = "JohN@soMething.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email # It's a good practice to use reload method to check what is exactly saved in the database
  end
  
  test "password should be present" do
    @chef.password = @chef.password_confirmation = ""
    assert_not @chef.valid?
  end
  
  test "password length should be more than 3" do
    @chef.password = @chef.password_confirmation = "12"
    assert_not @chef.valid?
  end
  
  test "password length should be less than 20" do
    @chef.password = @chef.password_confirmation = "12" * 21
    assert_not @chef.valid?
  end
  
end
