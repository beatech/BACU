class Tip < ActiveRecord::Base
  belongs_to :master_music,
    class_name: 'Master::Music',
    foreign_key: :master_music_id
  belongs_to :game_music,
    class_name: 'Game::Music',
    foreign_key: :game_music_id
  belongs_to :user,
    class_name: 'User',
    foreign_key: :user_id

  validates :user_id, presence: true
  validates :content, presence: true
end
