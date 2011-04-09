require 'test_helper'

class PendingTitlesForCollectionsControllerTest < ActionController::TestCase
  setup do
    @pending_titles_for_collection = pending_titles_for_collections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pending_titles_for_collections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pending_titles_for_collection" do
    assert_difference('PendingTitlesForCollection.count') do
      post :create, :pending_titles_for_collection => @pending_titles_for_collection.attributes
    end

    assert_redirected_to pending_titles_for_collection_path(assigns(:pending_titles_for_collection))
  end

  test "should show pending_titles_for_collection" do
    get :show, :id => @pending_titles_for_collection.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pending_titles_for_collection.to_param
    assert_response :success
  end

  test "should update pending_titles_for_collection" do
    put :update, :id => @pending_titles_for_collection.to_param, :pending_titles_for_collection => @pending_titles_for_collection.attributes
    assert_redirected_to pending_titles_for_collection_path(assigns(:pending_titles_for_collection))
  end

  test "should destroy pending_titles_for_collection" do
    assert_difference('PendingTitlesForCollection.count', -1) do
      delete :destroy, :id => @pending_titles_for_collection.to_param
    end

    assert_redirected_to pending_titles_for_collections_path
  end
end
