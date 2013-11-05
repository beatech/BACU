class UsersController < ApplicationController
  layout 'layouts/single_column'
  before_filter :require_login, only: [:edit, :update]
  before_filter :require_circle_account,
    only: [:master_circle_edit, :master_circle_update, :games_circle_edit, :games_circle_update]

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

  def master_circle_edit
  end

  def master_circle_update
    user = @user
    redirect_to master_path unless user && user.master_user.present?
    master_user = user.master_user
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

  def games_circle_edit
  end

  def games_circle_update
    user = @user
    redirect_to games_path unless user.present?
    Game.all.each do |game|
      total_score = 0
      game_total = Game::Total.where(user_id: user.id, game_id: game.id).first
      game_total = Game::Total.create(game_id: game.id, user_id: user.id, total_score: 0) if game_total.blank?
      game.game_musics.each do |music|
        game_score = Game::Score.where(game_total_id: game_total.id, game_music_id: music.id).first
        game_score = Game::Score.create(game_total_id: game_total.id, game_music_id: music.id, score: 0) if game_score.blank?
        game_score.score = params[:music][music.id.to_s].to_f
        total_score += game_score.score
        game_score.save
      end
      game_total.total_score = total_score
      game_total.save
    end
    redirect_to games_path
  end

  def require_circle_account
    circle = @twitter_account.circle
    redirect_to root_url if circle.blank?

    redirect_to root_url if params[:id].blank?
    @user = User.find(params[:id])
    redirect_to root_url unless circle.users.include?(@user)
  end

  private
  def create_params
    params.require(:user).permit(:twitter_account_id, :name, :circle_id)
  end

  def update_params
    params.require(:user).permit(:name, :circle_id)
  end
end
