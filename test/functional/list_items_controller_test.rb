require 'test_helper'

class ListItemsControllerTest < ActionController::TestCase
  setup do
    @list_item = list_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:list_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create list_item" do
    assert_difference('ListItem.count') do
      post :create, :list_item => @list_item.attributes
    end

    assert_redirected_to list_item_path(assigns(:list_item))
  end

  test "should show list_item" do
    get :show, :id => @list_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @list_item.to_param
    assert_response :success
  end

  test "should update list_item" do
    put :update, :id => @list_item.to_param, :list_item => @list_item.attributes
    assert_redirected_to list_item_path(assigns(:list_item))
  end

  test "should destroy list_item" do
    assert_difference('ListItem.count', -1) do
      delete :destroy, :id => @list_item.to_param
    end

    assert_redirected_to list_items_path
  end
end
