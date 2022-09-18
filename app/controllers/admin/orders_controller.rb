class Admin::OrdersController < ApplicationController
   before_action :authenticate_admin!
  
  def index
   if params[:customer_id]
     @customer = Customer.find(params[:customer_id])
     @orders = @customer.orders.all
   end
  end
  
  def show
   @order = Order.find(params[:id])
   @order_details = @order.order_details.all
  end
  
  def edit
   @order = Order.find(params[:id])
  end

  def update
   @order = Order.find(params[:id])
   @order.update(order_params)
   if @order.status == "confirmation"
     @order.order_details.update_all(making_status: 1)
   end
   flash[:notice_orderedit]="注文ステータスを更新しました"
   redirect_to admin_order_path(@order)
  end
  
  # https://teratail.com/questions/351090
  
  private
  
  def order_params
    params.require(:order).permit(:postal_code,:address,:name,:shiping_cost,:total_payment,:payment_method,:status,:customer_id)
  end
  
  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:enail,:postal_code,:address,:telephone_number,:is_deleted)
  end
  
end
