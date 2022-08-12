class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
  end

  def edit
  end
  
  def create
    @address = Address.new
  end
  
  def update 
  end
  
  def destroy
  end

end
