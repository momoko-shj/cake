class Admin::CustomersController < ApplicationController
   before_action :authenticate_admin!
  # before_action :configure_permitted_parameters, if: :devise_controller?
  
  def index
    @customers = Customer.page(params[:page])
    # @customers = Customer.all
    @customer = Customer.new
  end

  def show
   @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path
    else
      render :edit
    end
  end
  # 編集後にcustomerのマイページに遷移
  
  private
  
  def customer_params
   params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:postal_code,:address,:telephone_number,:is_deleted)
  end
  
  def order_params
   params.require(:order).permit(:postal_code,:address,:name,:shiping_cost,:total_payment,:payment_method,:status,:customer_id)
  end
  
end
