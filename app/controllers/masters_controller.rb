class MastersController < ApplicationController
  layout 'layouts/single_column'
  before_filter :require_login, only: [:edit, :update]

  def index
    @circles = Circle.all.map { |circle|
      if circle.master_circle
        circle.master_circle
      else
        Master::Circle.create(circle_id: circle.id, total_score: 0)
      end
    }.sort_by(&:total_score).reverse

    @users = User.all.map { |user|
      if user.master_user
        user.master_user
      else
        Master::User.create(user_id: user.id, total_score: 0)
      end
    }.sort_by(&:total_score).reverse
  end

  def edit
    user = @twitter_account.user
    if user.master_user.present?
      @user = user.master_user
    else
      @user = Master::User.create(user_id: user.id, total_score: 0)
    end
  end

  def update
    master_user = @twitter_account.user.master_user
    Master::Music.all.each do |music|
      score = Master::Score.where(
        master_user_id: master_user.id,
        master_music_id: music.id
      ).first
      score.update_basic_score(params[:music][music.id.to_s].to_f)
    end
    Master::User.update_total_score
    Master::Circle.update_total_score
    redirect_to master_path
  end

  private
  def require_login
    redirect_to root_url unless @twitter_account && @twitter_account.user.present?
  end
end
