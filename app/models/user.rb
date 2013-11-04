class User < ActiveRecord::Base
  belongs_to :twitter_account
  belongs_to :circle
  has_one :master_user, class_name: 'Master::User'
  validates :twitter_account_id, presence: true
  validates :name, presence: true
end
