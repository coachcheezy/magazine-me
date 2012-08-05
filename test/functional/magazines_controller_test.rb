require 'test_helper'

class MagazinesControllerTest < ActionController::TestCase
  setup do
    @magazine = magazines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:magazines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create magazine" do
    assert_difference('Magazine.count') do
      post :create, magazine: @magazine.attributes
    end

    assert_redirected_to magazine_path(assigns(:magazine))
  end

  test "should show magazine" do
    get :show, id: @magazine.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @magazine.to_param
    assert_response :success
  end

  test "should update magazine" do
    put :update, id: @magazine.to_param, magazine: @magazine.attributes
    assert_redirected_to magazine_path(assigns(:magazine))
  end

  test "should destroy magazine" do
    assert_difference('Magazine.count', -1) do
      delete :destroy, id: @magazine.to_param
    end

    assert_redirected_to magazines_path
  end
end
