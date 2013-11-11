class TipsController < ApplicationController
  layout 'layouts/single_column'
  before_filter :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def new
    @tip = Tip.new
    if params[:master_music_id]
      @tip.master_music_id = params[:master_music_id]
    elsif params[:game_music_id]
      @tip.game_music_id = params[:game_music_id]
    end
  end

  def create
    if params[:tip][:master_music_id]
      Tip.create(
        master_music_id: params[:tip][:master_music_id],
        user_id: @twitter_account.user.id,
        content: params[:tip][:content],
      )
    elsif params[:tip][:game_music_id]
      Tip.create(
        game_music_id: params[:tip][:game_music_id],
        user_id: @twitter_account.user.id,
        content: params[:tip][:content],
      )
    end
    redirect_to tips_path
  end

  def edit
    @tip = Tip.find(params[:id])
    if params[:master_music_id]
      @tip.master_music_id = params[:master_music_id]
    elsif params[:game_music_id]
      @tip.game_music_id = params[:game_music_id]
    end
  end

  def update
    tip = Tip.find(params[:id])
    if params[:tip][:master_music_id]
      tip.update(
        master_music_id: params[:tip][:master_music_id],
        user_id: @twitter_account.user.id,
        content: params[:tip][:content],
      )
    elsif params[:tip][:game_music_id]
      tip.update(
        game_music_id: params[:tip][:game_music_id],
        user_id: @twitter_account.user.id,
        content: params[:tip][:content],
      )
    end
    redirect_to tips_path
  end

  def destroy
    Tip.find(params[:id]).destroy
    redirect_to tips_path
  end

  def require_login
    redirect_to root_url unless @twitter_account && @twitter_account.user.present?
  end
end
