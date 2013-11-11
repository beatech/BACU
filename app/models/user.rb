class User < ActiveRecord::Base
  belongs_to :twitter_account,
    class_name: 'TwitterAccount',
    foreign_key: :twitter_account_id
  belongs_to :circle,
    class_name: 'Circle',
    foreign_key: :circle_id
  has_one :master_user,
    class_name: 'Master::User',
    foreign_key: :user_id
  has_many :game_totals,
    class_name: 'Game::Total',
    foreign_key: :user_id

  validates :twitter_account_id, presence: true
  validates :name, presence: true
end
