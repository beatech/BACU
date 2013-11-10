class Master::Circle < ActiveRecord::Base
  belongs_to :circle,
    class_name: '::Circle',
    foreign_key: :circle_id
  has_many :game_scores,
    class_name: 'Master::Circle::GameScore',
    foreign_key: :master_circle_id
  has_many :users,
    class_name: '::User',
    through: :circle
  has_many :master_users,
    class_name: 'Master::User',
    through: :users
  has_many :master_scores,
    class_name: 'Master::Score',
    through: :master_users

  validates :total_score, presence: true
  validates :circle_id, presence: true

  def name
    circle.name
  end

  def self.update_total_score
    Master::Circle.all.each do |master_circle|
      sum = 0
      master_circle.master_users.each do |master_user|
        sum += master_user.total_score
      end
      master_circle.total_score = sum
      master_circle.save
    end
  end

  def self.update_all_average
    Master::Circle.all.each do |master_circle|
      score_sum = 0
      master_circle.master_scores.each do |master_score|
        score_sum += master_score.score
      end
      master_circle.all_average = score_sum.to_f / master_circle.master_scores.count
      master_circle.save
    end
  end

  def self.update_all_average_point
    Master::Circle.all.each do |master_circle|
      circle_point = 400 + (master_circle.all_average - 50) * 25
      circle_point = 0 if circle_point < 0
      master_circle.all_average_point = circle_point
      master_circle.save
    end
  end
end
