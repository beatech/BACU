class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:uid] = user.username
      redirect_to :back
    else
      redirect_to root_url, notice: 'ログインに失敗しました。'
    end
  end

  def destroy
    session[:uid] = nil
    redirect_to root_url
  end

  def twitter_create
    auth = request.env['omniauth.auth']
    screen_name = auth[:info][:nickname]
    #profile_image = auth[:info][:image]
    uid = auth[:uid]

    raise Forbidden unless auth
    twitter_account = TwitterAccount.find_by_uid(uid)

    if twitter_account
      session[:uid] = twitter_account.uid
      redirect_to root_url
    else
      session[:uid] = uid
      TwitterAccount.create(uid: uid, screen_name: screen_name)
      redirect_to root_url
    end
  end
end
