class Game::Total < ActiveRecord::Base
  POINT_PARAMETER = 2.0

  has_many :game_scores,
    class_name: 'Game::Score'
  belongs_to :game,
    foreign_key: :game_id
  belongs_to :user,
    class_name: '::User',
    foreign_key: :user_id
  has_one :circle,
    class_name: '::Circle',
    through: :user

  validates :user_id, presence: true
  validates :game_id, presence: true
  validates :total_score, presence: true

  # x = 1/1 + 1/2 + 1/3 + ... + 1/n
  # (150/x + A)/1 , (150/x + A)/2 , (150/x + A)/3 ...
  def self.update_point
    ::Game.all.each do |game|
      game_totals = Game::Total.where(game_id: game.id).order('total_score DESC')
      user_count = game_totals.count
      sigma = self.sigma(user_count)
      game_totals.each_with_index do |game_total, index|
        game_total.point = ((150.0 / sigma + POINT_PARAMETER) / (index + 1)).to_i
        game_total.save
      end
    end
  end

  # 1/1 + 1/2 + 1/3 + ... + 1/n
  def self.sigma(n)
    1.upto(n).inject(0) do |sigma, k|
      sigma + 1.0 / k
    end
  end
end
