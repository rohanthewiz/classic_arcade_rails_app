require 'test_helper'

class LikesControllerTest < ActionController::TestCase
  setup do
    @like = likes(:one)
  end

  test 'should create like' do
    assert_difference ['Like.count', 'ActionMailer::Base.deliveries.size'], 1 do
      post :create, like: { game_id: games(:one).id }
    end
    assert_no_difference('Like.count', 'A user can only like a game once') do
      post :create, like: { game_id: games(:one).id }
    end
  end
end
