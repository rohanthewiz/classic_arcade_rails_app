require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  setup do
    @game = games(:one)
  end

  test 'likes can be created' do
    assert_difference('Like.count', 1) do
      like = Like.create(fan_ip: '99.0.0.0', game_id: @game.id)
      assert_not_nil like.id
      assert_equal '99.0.0.0', like.fan_ip
      assert_equal @game.id, like.game_id
    end
  end

  test 'should fail to create like on validation errors' do
    assert_no_difference('Like.count') do
      Like.create(fan_ip: '100.0.0.0')
      Like.create(game_id: @game.id)
    end
  end

  test 'should allow multiple likes of a game from different ips' do
    assert_difference('Like.count', 2) do
      Like.create(fan_ip: '99.0.0.3', game_id: @game.id)
      Like.create(fan_ip: '99.0.0.4', game_id: @game.id)
    end
  end

  test 'should not allow multiple likes from the same game and ip' do
    assert_difference('Like.count', 1) do
      Like.create(fan_ip: '99.0.0.5', game_id: @game.id)
    end
    assert_no_difference('Like.count') do
      Like.create(fan_ip: '99.0.0.5', game_id: @game.id)
    end
  end
end
