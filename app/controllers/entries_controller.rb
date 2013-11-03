class EntriesController < ApplicationController
  FRONTPAGE_ID = 1

  def index
    @entries = Entry.all
    @title = 'ページ一覧'

    respond_to do |format|
      format.html
      format.json { render json: Entry.all }
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def new
    @entry = Entry.new
    @title = 'ページの新規作成'
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def create
    @entry = Entry.new(user_params)
    @entry.entry_type = 0

    if @entry.save
      redirect_to edit_entry_path(@entry.url), notice: 'ページの作成に成功しました。'
    else
      redirect_to new_entry_path
    end
  end

  def update
    @entry = Entry.find(params[:id])

    if @entry.update_attributes(user_params)
      redirect_to entry_path(@entry), notice: 'ページを更新しました。'
    else
      redirect_to edit_entry_path(@entry)
    end
  end

  def destroy
    admin_required

    @entry = Entry.find_by_url(params[:id])
    @entry.destroy
    redirect_to entries_path
  end

  def frontpage
    Entry.create(title: 'bacu', content: 'bacu') unless Entry.where(id: 1).first
    Entry.create(title: 'bacu', content: 'bacu') unless Entry.where(id: 2).first
    @entry = Entry.find(FRONTPAGE_ID)
    render action: 'show'
  end

  private
  def user_params
    params.require(:entry).permit(:title, :content)
  end
end
