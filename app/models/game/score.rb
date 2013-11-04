class Game::Score < ActiveRecord::Base
  belongs_to :game_total, class_name: 'Game::Total'
  validates :score, presence: true
  validates :game_total_id, presence: true
  validates :game_music_id, presence: true
end
