class UsersController < ApplicationController
  def create
    user = User.create(create_params)
    if user && user.valid?
      redirect_to welcome_user_path
    else
      redirect_to member_registration_path
    end
  end

  def welcome
  end

  private
  def create_params
    params.require(:user).permit(:twitter_account_id, :name, :circle_id)
  end
end
