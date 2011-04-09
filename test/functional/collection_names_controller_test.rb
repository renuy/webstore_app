require 'test_helper'

class CollectionNamesControllerTest < ActionController::TestCase
  setup do
    @collection_name = collection_names(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:collection_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create collection_name" do
    assert_difference('CollectionName.count') do
      post :create, :collection_name => @collection_name.attributes
    end

    assert_redirected_to collection_name_path(assigns(:collection_name))
  end

  test "should show collection_name" do
    get :show, :id => @collection_name.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @collection_name.to_param
    assert_response :success
  end

  test "should update collection_name" do
    put :update, :id => @collection_name.to_param, :collection_name => @collection_name.attributes
    assert_redirected_to collection_name_path(assigns(:collection_name))
  end

  test "should destroy collection_name" do
    assert_difference('CollectionName.count', -1) do
      delete :destroy, :id => @collection_name.to_param
    end

    assert_redirected_to collection_names_path
  end
end
