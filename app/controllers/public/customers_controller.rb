class Public::CustomersController < ApplicationController 
  
  
  def new
    @customer = Customer.new
  end
  
  def show
    @customer = current_customer
  end
  
  def edit
    # @customer = Customer.find(params[:id])
    @customer = current_customer
  end
    
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice_create]="お客様情報を変更しました"
      redirect_to customer_path
    else
      render :edit
    end
  end
  
  def unsubscribe
    @customer = current_customer
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました。"
    redirect_to root_path
  end

private
  
  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:postal_code,:address,:telephone_number,:is_deleted)
  end
  
end