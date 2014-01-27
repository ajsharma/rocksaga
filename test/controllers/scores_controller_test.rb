require 'test_helper'

class ScoresControllerTest < ActionController::TestCase
  setup do
    @score = FactoryGirl.build(:score)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scores)
  end

  test "should create score" do
    assert_difference('Score.count') do
      post :create, score: { name: "Joe", score: 100 }
    end

    assert_redirected_to score_path(assigns(:score))
  end
end
