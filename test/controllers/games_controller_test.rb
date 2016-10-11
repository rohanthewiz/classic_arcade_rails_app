require 'test_helper'
# Todo - Mail Controller test
# Todo - Clean up comments
class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
    active_games = Game.where(is_active: true).count
    assert_equal active_games, assigns(:games).count, 'Only active games should be listed'
  end

  test 'should show game' do
    get :show, id: @game, format: :json
    assert_response :success
  end
end
