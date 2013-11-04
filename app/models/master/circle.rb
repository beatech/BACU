class Master::Circle < ActiveRecord::Base
  belongs_to :circle, class_name: '::Circle'
  has_many :users, class_name: '::User', through: :circle
  has_many :master_users, class_name: 'Master::User', through: :users
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
end
