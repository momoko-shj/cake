class Public::CartItemsController < ApplicationController
 
 def index
   @cart_items = current_customer.cart_items.all
   @total = 0
 end
 
 def create
   @total = 0
   @cart_item = current_customer.cart_items.new(cart_item_params)
   cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if cart_item.present?
     cart_item.amount += params[:cart_item][:amount].to_i
     cart_item.save
     redirect_to cart_items_path
    else
     @cart_item.save
     @cart_items = current_customer.cart_items.all
     render 'index'
    end
  end
 
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: params[:cart_item][:amount].to_i)
    redirect_to cart_items_path 
  end

  def destroy_all
   current_customer.cart_items.destroy_all
    flash[:notice_create]="カートが空になりました"
    redirect_to cart_items_path
  end
  
  def destroy
   @cart_item = CartItem.find(params[:id])
   @cart_item.destroy
    flash[:notice_create]="商品を削除しました"
   redirect_to cart_items_path
  end
  
  
private
  
def cart_item_params
  params.require(:cart_item).permit(:item_id, :amount)
end


end
