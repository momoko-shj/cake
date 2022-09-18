class Public::OrdersController < ApplicationController
  
  def new
    @customer = current_customer
    @order = Order.new
  end
  
  def comfirm
    @customer = current_customer
    @cart_items = current_customer.cart_items.all
    @total = 0
    @order = Order.new(order_params)
    @shipping_cost = 800
    
    if params[:order][:select_address] == "0"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      
    elsif params[:order][:select_address] == "1"
      @order.name = Address.find(params[:order][:address_id]).name
      @order.address = Address.find(params[:order][:address_id]).address
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
     
    elsif params[:order][:select_address] == "2"
      @order.name
      @order.address
      @order.postal_code
    end
    
    # if @order.save
    #   redirect_to thanks_path
    # else
    #   render :comfirm
    # end
    
  end
  
  def create
    @customer = current_customer
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart.amount
        order_detail.price = cart.item.price
        order_detail.save
      end
      redirect_to thanks_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params) 
      render :new
    end
  end
  
  
    # https://qiita.com/HAMO-ss/items/13665dd0370a22b8e166
  
  def thanks
    
  end
  
  def index
    @orders = current_customer.orders.all
  end
  
  def show
    @order =  Order.find(params[:id])
    @total = 0
    @shipping_cost = 800
  end
  
private
  
  def order_params
   params.require(:order).permit(:postal_code,:address,:name,:shipping_cost,:total_payment,:payment_method)
  end
  
  def address_params
    params.require(:order).permit(:name, :address,:postal_code)
  end

  
end
