class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: {制作不可:0, 制作待ち:1, 製作中:2, 制作完了:3}

  def subtotal
    self.item.with_tax_price.to_i * self.amount.to_i
  end

end