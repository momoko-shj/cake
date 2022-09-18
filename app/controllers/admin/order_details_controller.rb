class Admin::OrderDetailsController < ApplicationController
   before_action :authenticate_admin!
  
 def update
   @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id]) 
   @order_detail.update(order_detail_params)
   if @order_detail.making_status == "making"
     @order_detail.order.update(status: 2)
   elsif @order_detail.order.order_details.count == @order_detail.order.order_details.where(making_status: "completed").count
     @order_detail.order.update(status: 3)
   end
   redirect_to admin_order_path(@order_detail.order)
 end
 
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:price,:amount,:making_status,:item_id,:order_id)
  end
  
end
