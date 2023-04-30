class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details

  has_one_attached :item_image

  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      item_image.variant(resize_to_limit: [100, 100]).processed
  end


 def with_tax_price
    (price * 1.1).floor
 end

  enum sale_status: {販売中:0,販売停止:1}

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

end
