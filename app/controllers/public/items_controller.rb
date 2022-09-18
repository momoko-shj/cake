class Public::ItemsController < ApplicationController
  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page])
    else
      @items = Item.page(params[:page])
    end
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end
  
 

private
  
def item_params
  params.require(:item).permit(:name,:introduction,:price,:is_active,:genre_id)
end

end
