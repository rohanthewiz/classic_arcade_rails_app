require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  test 'photo can be created' do
    assert_difference('Photo.count', 1) do
      photo = Photo.create(url: 'ab/cd/ef/fg.jpg', thumb: 'fg.png')
      assert_not_nil photo.id
      assert_equal 'ab/cd/ef/fg.jpg', photo.url
      assert_equal 'fg.png', photo.thumb
    end
  end

  test 'photo will not be created on validation error' do
    assert_no_difference('Photo.count') do
      Photo.create(url: 'ab/cd/ef/fg.jpg', thumb: '')
      Photo.create(url: '', thumb: 'my.png')
    end
  end
end
