class User < ActiveRecord::Base
  has_one :twitter_account
  validates :twitter_account_id, presence: true
  validates :name, presence: true
end
