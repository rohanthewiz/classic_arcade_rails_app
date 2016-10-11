require 'test_helper'

class GameDetailFlowsTest < ActionDispatch::IntegrationTest
  test 'game detail' do
    get '/games'
    assert_response :success
    assert assigns(:games)
    assert_select '#game-detail'
    names = css_select '.game-name'
    # wish I could click elements here!
  end
end
