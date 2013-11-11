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

  def self.initialize_point
    Game::Total.all.each do |game_total|
      game_total.point = 0
      game_total.save
    end
  end

  # n人中x位のスコアf(x)を計算する。
  # プレー者に反比例で合計150点を与える。
  # A = POINT_PARAMETER
  # Σ = 1/(1 + A) + 1/(2 + A) + ... + 1/(n + A)
  # f(x) = (150/Σ)/(x + A)
  def self.update_point
    self.initialize_point
    ::Game.all.each do |game|
      game_totals = Game::Total.where(game_id: game.id).where('total_score > 0').order('total_score DESC')
      user_count = game_totals.count
      sigma = self.sigma(user_count)
      game_totals.each_with_index do |game_total, index|
        rank = index + 1
        game_total.point = ((150.0 / sigma) / (rank + POINT_PARAMETER)).to_i
        game_total.save
      end
    end
  end

  # Σ = 1/(1 + A) + 1/(2 + A) + ... + 1/(n + A)
  def self.sigma(n)
    1.upto(n).inject(0) do |sigma, k|
      sigma + 1.0 / (k + POINT_PARAMETER)
    end
  end
end
