require 'test_helper'

class EvolutionsControllerTest < ActionController::TestCase
  setup do
    @evolution = evolutions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evolutions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evolution" do
    assert_difference('Evolution.count') do
      post :create, :evolution => @evolution.attributes
    end

    assert_redirected_to evolution_path(assigns(:evolution))
  end

  test "should show evolution" do
    get :show, :id => @evolution.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @evolution.to_param
    assert_response :success
  end

  test "should update evolution" do
    put :update, :id => @evolution.to_param, :evolution => @evolution.attributes
    assert_redirected_to evolution_path(assigns(:evolution))
  end

  test "should destroy evolution" do
    assert_difference('Evolution.count', -1) do
      delete :destroy, :id => @evolution.to_param
    end

    assert_redirected_to evolutions_path
  end
end
