class Game::Music < ActiveRecord::Base
  belongs_to :game
  has_many :tips,
    class_name: '::Tip',
    foreign_key: :game_music_id
  validates :title, presence: true
  validates :difficulty, presence: true
  validates :game_id, presence: true
end
