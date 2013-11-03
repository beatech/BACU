class CirclesController < ApplicationController
  def create
    circle = Circle.create(create_params)
    if circle && circle.valid?
      redirect_to welcome_circle_path
    else
      redirect_to circle_registration_path
    end
  end

  def welcome
  end

  private
  def create_params
    params.require(:circle).permit(:twitter_account_id, :name, :university, :url)
  end
end
