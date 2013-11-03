class RegistrationController < ApplicationController
  def index
  end

  def create
    account_type = params[:account]
    redirect_to registration_path unless %w(member circle).include?(account_type)
    redirect_to send("#{account_type}_registration_path")
  end
end
