class Master::Circle < ActiveRecord::Base
  belongs_to :circle, class_name: '::Circle'
  validates :total_score, presence: true
  validates :circle_id, presence: true

  def name
    circle.name
  end
end
