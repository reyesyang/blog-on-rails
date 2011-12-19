require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @admin = Factory :user
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create, :name => @admin.name, :password => @admin.password
    assert_redirected_to admin_path
  end

  test "should get destroy" do
    login @admin
    get :destroy
    assert_redirected_to articles_path
  end
end
