require 'test_helper'

class FirecarsControllerTest < ActionController::TestCase
  setup do
    @firecar = firecars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:firecars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create firecar" do
    assert_difference('Firecar.count') do
      post :create, firecar: {  }
    end

    assert_redirected_to firecar_path(assigns(:firecar))
  end

  test "should show firecar" do
    get :show, id: @firecar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @firecar
    assert_response :success
  end

  test "should update firecar" do
    patch :update, id: @firecar, firecar: {  }
    assert_redirected_to firecar_path(assigns(:firecar))
  end

  test "should destroy firecar" do
    assert_difference('Firecar.count', -1) do
      delete :destroy, id: @firecar
    end

    assert_redirected_to firecars_path
  end
end
