class Public::AddressesController < ApplicationController
  
  def index
    @customer = current_customer
    @addresses = @customer.addresses
    @address = Address.new
  end
  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice_create]="新しい配達先を追加しました"
      redirect_to addresses_path
    else
      render :index
    end
  end
  
  def edit
    @address = Address.find(params[:id])
  end
 
  def update 
     @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice_create]="配達先を変更しました"
      redirect_to addresses_path
    else
      render :edit
    end
  end
  
  def destroy
     @address = Address.find(params[:id])
    if @address.delete
      flash[:notice_create]="配達先を削除しました"
      redirect_to addresses_path
    else
      render :edit
    end
  end
  
    
private
  
def address_params
  params.require(:address).permit(:postal_code,:address,:name,:customer)
end

end