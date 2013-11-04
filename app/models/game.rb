class Game < ActiveRecord::Base
  has_many :master_musics, class_name: 'Master::Music'
  has_many :game_totals, class_name: 'Game::Total'
  has_many :game_musics, class_name: 'Game::Music'
  validates :title, presence: true
end
