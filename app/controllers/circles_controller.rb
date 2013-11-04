class CirclesController < ApplicationController
  before_filter :require_login, only: [:edit, :update]

  def require_login
    redirect_to root_url unless @twitter_account && @twitter_account.circle.present?
  end

  def create
    circle = Circle.create(create_params)
    if circle && circle.valid?
      redirect_to welcome_circle_path
    else
      redirect_to circle_registration_path
    end
  end

  def edit
    @circle = @twitter_account.circle
  end

  def update
    @circle = @twitter_account.circle
    @circle.update_attributes(update_params)
    redirect_to root_url
  end

  def welcome
  end

  private
  def create_params
    params.require(:circle).permit(:twitter_account_id, :name, :university, :url)
  end

  def update_params
    params.require(:circle).permit(:name, :university, :url)
  end
end
