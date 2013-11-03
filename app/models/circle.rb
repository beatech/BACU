class Circle < ActiveRecord::Base
  has_one :twitter_account
  validates :name, presence: true
  validates :university, presence: true
  validates :url, presence: true
end
