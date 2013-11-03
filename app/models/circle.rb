class Circle < ActiveRecord::Base
  belongs_to :twitter_account
  validates :name, presence: true
  validates :university, presence: true
  validates :url, presence: true
end
