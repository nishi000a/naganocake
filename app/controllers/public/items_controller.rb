class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @counts = Item.count
    @items = Item.all.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :item_image, :introduction, :price, :is_active)
  end


end



# items GET    /items(.:format)    public/items#index
# item GET    /items/:id(.:format)   public/items#show

# id	商品ID	◯		integer
# genre_id	ジャンルID		◯	integer
# name	商品名			string
# image_id	商品画像ID			string
# introduction	商品説明文			text
# price	税抜き価格			integer
# is_active	販売ステータス			boolean
# created_at	登録日時			datetime
# updated_at	更新日時			datetime