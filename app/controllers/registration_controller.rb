class RegistrationController < ApplicationController
  before_filter :registration_check

  def index
  end

  def create
    account_type = params[:account]
    redirect_to registration_path unless %w(member circle).include?(account_type)
    redirect_to send("#{account_type}_registration_path")
  end

  def circle
    @circle = Circle.new(
      twitter_account_id: @twitter_account.id,
      name: @twitter_account.screen_name,
      university: '○○大学',
      url: "https://twitter.com/#{@twitter_account.screen_name}",
    )
  end

  def member
    @user = User.new(
      twitter_account_id: @twitter_account.id,
      circle_id: 0,
      name: @twitter_account.screen_name,
    )
  end

  def registration_check
    redirect_to root_url if @twitter_account.registered?
  end
end
