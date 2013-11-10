class Circle < ActiveRecord::Base
  belongs_to :twitter_account
  has_one :master_circle,
    class_name: 'Master::Circle',
    foreign_key: :circle_id
  has_many :game_totals,
    class_name: 'Game::Total',
    through: :users
  has_many :users,
    class_name: 'User',
    foreign_key: :circle_id
  has_many :master_users,
    class_name: 'Master::User',
    through: :master_circle

  validates :name, presence: true
  validates :university, presence: true
  validates :url, presence: true

  def self.update_point
    Circle.all.each do |circle|
      point = 0
      point += master_individual_point(circle.master_users)
      point += master_circle_game_score_point(circle.master_circle.game_scores)
      point += circle.master_circle.all_average_point
      point += game_total_point(circle.game_totals)
      circle.point = point
      circle.save
    end
  end

  def self.master_individual_point(master_users)
    point_sum = 0
    master_users.pluck(:individual_point).each do |individual_point|
      point_sum += individual_point
    end
    point_sum
  end

  def self.master_circle_game_score_point(master_circle_game_scores)
    point_sum = 0
    master_circle_game_scores.pluck(:point).each do |point|
      point_sum += point
    end
    point_sum
  end

  def self.game_total_point(game_totals)
    point_sum = 0
    game_totals.pluck(:point).each do |point|
      point_sum += point
    end
    point_sum
  end
end
