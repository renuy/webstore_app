require 'test_helper'

class RenewalsControllerTest < ActionController::TestCase
  setup do
    @renewal = renewals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:renewals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create renewal" do
    assert_difference('Renewal.count') do
      post :create, :renewal => @renewal.attributes
    end

    assert_redirected_to renewal_path(assigns(:renewal))
  end

  test "should show renewal" do
    get :show, :id => @renewal.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @renewal.to_param
    assert_response :success
  end

  test "should update renewal" do
    put :update, :id => @renewal.to_param, :renewal => @renewal.attributes
    assert_redirected_to renewal_path(assigns(:renewal))
  end

  test "should destroy renewal" do
    assert_difference('Renewal.count', -1) do
      delete :destroy, :id => @renewal.to_param
    end

    assert_redirected_to renewals_path
  end
end
