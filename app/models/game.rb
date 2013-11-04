class Game < ActiveRecord::Base
  has_many :master_musics, class_name: 'Master::Music'
  validates :title, presence: true
end
