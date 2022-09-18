class Admin::GenresController < ApplicationController
   before_action :authenticate_admin!
   
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice_create]="ジャンルの追加に成功しました"
      redirect_to admin_genres_path(@genre)
    else
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
   @genre = Genre.find(params[:id])
   @genre.update(genre_params)
   if @genre.save
      flash[:notice_genreedit]="ジャンルの更新に成功しました" 
      redirect_to admin_genres_path(@genre)
   else
      render :edit
   end
  end
  
  def destroy
   @genre = Genre.find(params[:id])
   @genre.destroy
    flash[:notice_create]="ジャンルを削除しました"
   redirect_to admin_genres_path
  end
  

  
private

  def genre_params
    params.require(:genre).permit(:name)
  end
  
end