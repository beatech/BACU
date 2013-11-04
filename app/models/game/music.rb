class Game::Music < ActiveRecord::Base
  belongs_to :game
  validates :title, presence: true
  validates :difficulty, presence: true
  validates :game_id, presence: true
end
