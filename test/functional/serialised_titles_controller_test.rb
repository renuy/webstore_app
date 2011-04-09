require 'test_helper'

class SerialisedTitlesControllerTest < ActionController::TestCase
  setup do
    @serialised_title = serialised_titles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:serialised_titles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create serialised_title" do
    assert_difference('SerialisedTitle.count') do
      post :create, :serialised_title => @serialised_title.attributes
    end

    assert_redirected_to serialised_title_path(assigns(:serialised_title))
  end

  test "should show serialised_title" do
    get :show, :id => @serialised_title.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @serialised_title.to_param
    assert_response :success
  end

  test "should update serialised_title" do
    put :update, :id => @serialised_title.to_param, :serialised_title => @serialised_title.attributes
    assert_redirected_to serialised_title_path(assigns(:serialised_title))
  end

  test "should destroy serialised_title" do
    assert_difference('SerialisedTitle.count', -1) do
      delete :destroy, :id => @serialised_title.to_param
    end

    assert_redirected_to serialised_titles_path
  end
end
