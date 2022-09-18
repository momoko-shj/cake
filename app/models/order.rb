class Order < ApplicationRecord
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, confirmation: 1, making: 2, shipping_preparation: 3, shipped: 4 }
  
  has_many :order_details,dependent: :destroy
  belongs_to :customer
  
 has_one_attached :image
  
  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path),filename: 'default-image.jpg',content_type:'image/jpeg')
    end
    image.variant(resize_to_limit: [width,height]).processed
  end
  
  def subtotal
    item.with_tax_price * amount
  end
  
  def with_tax_price
   (price * 1.1).floor
  end
  
validates :postal_code, presence: true
validates :address, presence: true
validates :name, presence: true
  
end
