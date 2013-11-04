class Circle < ActiveRecord::Base
  belongs_to :twitter_account
  has_one :master_circle, class_name: 'Master::Circle'
  has_many :users, class_name: 'User'
  has_many :master_users, class_name: 'Master::User', through: :master_circle
  validates :name, presence: true
  validates :university, presence: true
  validates :url, presence: true
end
