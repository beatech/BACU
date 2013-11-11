class TwitterAccount < ActiveRecord::Base
  has_one :user,
    class_name: 'User',
    foreign_key: :twitter_account_id
  has_one :circle

  validates :uid, presence: true
  validates :screen_name, presence: true

  def registered?
    self.user.present? || self.circle.present?
  end

  def admin?
    %w(ikstrm chi08ka sophimet).include?(screen_name)
  end
end
