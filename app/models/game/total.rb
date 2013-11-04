class Game::Total < ActiveRecord::Base
  has_many :game_scores, class_name: 'Game::Score'
  belongs_to :game
  belongs_to :user, class_name: '::User'
  validates :user_id, presence: true
  validates :game_id, presence: true
  validates :total_score, presence: true
end
