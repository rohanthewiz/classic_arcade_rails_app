require 'test_helper'

class GameTest < ActiveSupport::TestCase
  setup do
    @photo = photos(:one)
  end

  test 'games creation' do
    assert_difference('Game.count', 1) do
      game = Game.create(name: 'ABCgame', year: 1982, is_active: true)
      assert_not_nil game.id
      assert_equal 'ABCgame', game.name
      assert_equal 1982, game.year
      assert game.is_active, 'game should be active'
      game.photo = @photo
      game.save
      assert_equal @photo.id, game.photo_id, 'should be able to associate a photo with a game'
    end
  end

  test 'should fail to create game on validation errors' do
    assert_no_difference('Game.count') do
      Game.create(name: 'Whizer', year: 1973)
      Game.create(name: 'Whizer', is_active: true)
      Game.create(year: 1973, is_active: true)
    end
  end
end
