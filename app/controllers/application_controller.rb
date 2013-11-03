class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authorize, :require_registration

  def authorize
    if session[:uid]
      @twitter_account = TwitterAccount.find_by_uid(session[:uid])
      session.delete(:uid) unless @twitter_account
    end
  end

  def require_registration
    return if controller_name == 'registration'
    redirect_to registration_path if @twitter_account && @twitter_account.registered? == false
  end
end
