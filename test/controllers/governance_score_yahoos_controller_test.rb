require 'test_helper'

class GovernanceScoreYahoosControllerTest < ActionController::TestCase
  setup do
    @governance_score_yahoo = governance_score_yahoos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:governance_score_yahoos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create governance_score_yahoo" do
    assert_difference('GovernanceScoreYahoo.count') do
      post :create, governance_score_yahoo: {  }
    end

    assert_redirected_to governance_score_yahoo_path(assigns(:governance_score_yahoo))
  end

  test "should show governance_score_yahoo" do
    get :show, id: @governance_score_yahoo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @governance_score_yahoo
    assert_response :success
  end

  test "should update governance_score_yahoo" do
    patch :update, id: @governance_score_yahoo, governance_score_yahoo: {  }
    assert_redirected_to governance_score_yahoo_path(assigns(:governance_score_yahoo))
  end

  test "should destroy governance_score_yahoo" do
    assert_difference('GovernanceScoreYahoo.count', -1) do
      delete :destroy, id: @governance_score_yahoo
    end

    assert_redirected_to governance_score_yahoos_path
  end
end
