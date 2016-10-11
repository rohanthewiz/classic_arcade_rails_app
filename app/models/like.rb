class Like < ActiveRecord::Base
  belongs_to :game

  validates :fan_ip, presence: true, uniqueness: {scope: :game_id}
  validates :game_id, presence: true
end
