# -*- encoding : utf-8 -*-
require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @admin = Factory :user
  end

  test "should get index" do
    login @admin
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    login @admin
    get :new
    assert_response :success
  end

  test "should create user" do
    login @admin
    assert_difference('User.count') do
      post :create, :user => Factory.attributes_for(:user)
    end

    assert_redirected_to users_path
  end

  test "should show user" do
    login @admin
    get :show, :id => @admin.to_param
    assert_response :success
  end

  test "should get edit" do
    login @admin
    get :edit, :id => @admin.to_param
    assert_response :success
  end

  test "should update user" do
    login @admin
    put :update, :id => @admin.to_param, :user => Factory.attributes_for(:user)
    assert_redirected_to users_path
  end

  test "should destroy user" do
    login @admin
    user = Factory :user
    assert_difference('User.count', -1) do
      delete :destroy, :id => user.to_param
    end

    assert_redirected_to users_path
  end
end
