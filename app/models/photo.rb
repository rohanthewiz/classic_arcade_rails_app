class Photo < ActiveRecord::Base
  has_many :games

  validates :url, presence: true
  validates :thumb, presence: true
end
