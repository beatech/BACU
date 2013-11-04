class UsersController < ApplicationController
  before_filter :require_login, only: [:edit, :update]

  def require_login
    redirect_to root_url unless @twitter_account.user.present?
  end

  def create
    user = User.create(create_params)
    if user && user.valid?
      redirect_to welcome_user_path
    else
      redirect_to member_registration_path
    end
  end

  def edit
    @user = @twitter_account.user
  end

  def update
    @user = @twitter_account.user
    @user.update_attributes(update_params)
    redirect_to root_url
  end

  def welcome
  end

  private
  def create_params
    params.require(:user).permit(:twitter_account_id, :name, :circle_id)
  end

  def update_params
    params.require(:user).permit(:name, :circle_id)
  end
end
