class Game < ActiveRecord::Base
  belongs_to  :photo
  has_many  :likes, dependent: :destroy

  validates :name, presence: true
  validates :year, presence: true
  validates :is_active, presence: true
end
