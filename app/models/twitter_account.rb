class TwitterAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :circle

  validates :uid, presence: true
  validates :screen_name, presence: true

  def registered?
    self.user.present? || self.circle.present?
  end
end
