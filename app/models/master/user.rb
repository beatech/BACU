class Master::User < ActiveRecord::Base
  belongs_to :user, class_name: '::User'
  has_one :circle, class_name: '::Circle', through: :user
  has_many :master_scores, class_name: 'Master::Score'
  validates :total_score, presence: true
  validates :user_id, presence: true

  def name
    user.name
  end

  def circle_name
    return '無所属' unless user.circle
    user.circle.name
  end

  def self.update_total_score
    Master::User.all.each do |user|
      user.total_score = Master::Score.where(master_user_id: user.id).inject(0) { |sum, master_score|
        sum + master_score.score
      }
      user.save
    end
  end
end
