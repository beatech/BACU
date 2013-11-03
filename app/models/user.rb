class User < ActiveRecord::Base
  belongs_to :twitter_account
  validates :twitter_account_id, presence: true
  validates :name, presence: true
end
