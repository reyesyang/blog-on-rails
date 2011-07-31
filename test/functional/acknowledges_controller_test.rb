require 'test_helper'

class AcknowledgesControllerTest < ActionController::TestCase
  setup do
    @acknowledge = acknowledges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:acknowledges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create acknowledge" do
    assert_difference('Acknowledge.count') do
      post :create, :acknowledge => @acknowledge.attributes
    end

    assert_redirected_to acknowledge_path(assigns(:acknowledge))
  end

  test "should show acknowledge" do
    get :show, :id => @acknowledge.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @acknowledge.to_param
    assert_response :success
  end

  test "should update acknowledge" do
    put :update, :id => @acknowledge.to_param, :acknowledge => @acknowledge.attributes
    assert_redirected_to acknowledge_path(assigns(:acknowledge))
  end

  test "should destroy acknowledge" do
    assert_difference('Acknowledge.count', -1) do
      delete :destroy, :id => @acknowledge.to_param
    end

    assert_redirected_to acknowledges_path
  end
end
