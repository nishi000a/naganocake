class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @counts = Item.count
    @total = 0
  end

  def create
      @cart_item_check = CartItem.find_by(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])
    if @cart_item_check
      @cart_item_check.amount += params[:cart_item][:amount].to_i
      @cart_item_check.save
      flash[:success] = "商品を追加しました"
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        flash[:success] = "カートに追加しました"
        redirect_to cart_items_path
      else
        flash[:danger] = "正しい個数を入力してください"
        redirect_back(fallback_location: root_path)
      end
    end
  end


  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
       flash[:success] = "個数を変更しました"
       redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "正しい個数を入力してください"
      redirect_back(fallback_location: root_path)
    end
  end


  def destroy_all
    CartItem.where(customer_id: current_customer.id).destroy_all
    flash[:success] = "カートを全て空にしました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:success] = "カートを空にしました"
    redirect_back(fallback_location: root_path)
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end



# cart_items GET    /cart_items(.:format) public/cart_items#index
#             POST   /cart_items(.:format)  public/cart_items#create
# cart_item PATCH  /cart_items/:id(.:format) public/cart_items#update
#           PUT    /cart_items/:id(.:format) public/cart_items#update
#           DELETE /cart_items/:id(.:format) public/cart_items#destroy
# cart_items_destroy_all DELETE /cart_items/destroy_all(.:format) public/cart_items#destroy_all

# id	カート内商品ID	◯		integer	◯	◯	◯
# item_id	商品ID		◯	integer	◯
# customer_id	会員ID		◯	integer	◯
# amount	数量			integer	◯
# created_at	登録日時			datetime	◯			now
# updated_at	更新日時			datetime	◯			now

