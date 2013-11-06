class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authorize, :require_registration

  def authorize
    if session[:uid]
      @twitter_account = TwitterAccount.find_by_uid(session[:uid])
      session.delete(:uid) unless @twitter_account
    else
      @twitter_account = nil
    end
  end

  def require_registration
    return if registration_action?
    redirect_to registration_path if @twitter_account && @twitter_account.registered? == false
  end

  def registration_action?
    return true if controller_name == 'sessions'
    return true if controller_name == 'registration'
    return true if controller_name == 'circles' && action_name == 'create'
    return true if controller_name == 'users' && action_name == 'create'
    false
  end

  def require_admin
    redirect_to root_url unless @twitter_account && @twitter_account.admin?
  end
end
