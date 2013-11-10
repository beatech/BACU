class Master::User < ActiveRecord::Base
  belongs_to :user,
    class_name: '::User',
    foreign_key: :user_id
  has_one :circle,
    class_name: '::Circle',
    through: :user
  has_one :master_circle,
    class_name: 'Master::Circle',
    through: :circle
  has_many :master_scores,
    class_name: 'Master::Score',
    foreign_key: :master_user_id

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

  def self.update_individual_point
    Master::User.order('total_score desc').each_with_index do |master_user, index|
      if 30 > index
        master_user.individual_point = (50 * ((30 - index).to_f / 30)).to_i
      else
        master_user.individual_point = 0
      end
      master_user.save
    end
  end
end
