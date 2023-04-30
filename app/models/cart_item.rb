class CartItem < ApplicationRecord

  validates :amount, numericality: { only_integer: true, greater_than: 0, less_than: 1000 }

  belongs_to :customer
	belongs_to :item

  has_one_attached :image_id

  def subtotal
    self.item.with_tax_price.to_i * self.amount.to_i
  end


end