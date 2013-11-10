class Game < ActiveRecord::Base
  has_many :master_musics,
    class_name: 'Master::Music',
    foreign_key: :game_id
  has_many :master_scores,
    class_name: 'Master::Score',
    through: :master_musics
  has_many :game_totals,
    class_name: 'Game::Total',
    foreign_key: :game_id
  has_many :game_musics,
    class_name: 'Game::Music',
    foreign_key: :game_id
  has_many :master_circle_game_scores,
    class_name: 'Master::Circle::GameScore',
    foreign_key: :game_id

  validates :title, presence: true
end
