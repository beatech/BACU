class Circle < ActiveRecord::Base
  belongs_to :twitter_account
  has_one :master_circle, class_name: 'Master::Circle'
  validates :name, presence: true
  validates :university, presence: true
  validates :url, presence: true
end
