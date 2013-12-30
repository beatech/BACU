module ApplicationHelper
  def login_as_user_account?
    @login ||= login_user_id.present?
  end

  def login_user_id
    @user_id ||=
      @twitter_account.present? &&
      @twitter_account.user.present? &&
      @twitter_account.user.id
  end
end
