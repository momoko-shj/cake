class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @items = Item.page(params[:page])
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice_create]="新商品を追加しました"
      redirect_to admin_item_path(@item)
    else
      render :index
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @genre = @item.genre
  end
  
  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_items_path
    else
     render :edit
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :genre_id, :making_status)
  end

end