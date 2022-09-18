class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum making_status: {pending: 0,waiting: 1, making: 2, completed: 3}
  
  
  def subtotal
    item.with_tax_price * amount
  end
  
  def with_tax_price
   (price * 1.1).floor
  end
  
end
