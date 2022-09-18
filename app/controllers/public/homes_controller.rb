class Public::HomesController < ApplicationController
  
  def top
    @genres = Genre.all
    @items = Item.where(is_active:true).order(updated_at: :desc).limit(4)
  end

  def about
  end
  

private
  
def item_params
  params.require(:item).permit(:name,:introduction,:price,:is_active)
end

end

