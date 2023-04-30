class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :cart_check, only: [:new, :confirm, :create]

  def cart_check
    unless CartItem.find_by(customer_id: current_customer.id)
      flash[:danger] = "カートに商品を追加してください"
      redirect_to cart_items_path
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @orders = current_customer.orders
    @total = 0
  end

  def new
    @order = Order.new
    @orders = current_customer.orders.all
    @customer = Customer.find(current_customer.id)
  end

  def confirm
    params[:order][:payment_method] = params[:order][:payment_method].to_i
    @order = Order.new(order_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postal_code = current_customer.postal_code
    @order.name = current_customer.last_name + current_customer.first_name
    @order.address = current_customer.address
      if @order.save
        current_customer.cart_items.each do |cart_item|
          @order_detail = OrderDetail.new
          @order_detail.item_id = cart_item.item_id
          @order_detail.amount = cart_item.amount
          @order_detail.price = (cart_item.item.price.to_i * 1.1).floor
          @order_detail.order_id =  @order.id
          @order_detail.save
        end
        current_customer.cart_items.destroy_all
        redirect_to orders_complete_path
      else
        @orders = Order.all
        render 'index'
      end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :shipping_cost, :total_payment, :status,:postal_code,:name,:address)
  end

end



# id	注文ID	◯		integer	◯
# customer_id	会員ID		◯	integer	◯
# postal_code	配送先郵便番号			string	◯
# address	配送先住所			string	◯
# name	配送先宛名			string	◯
# shipping_cost	送料			integer	◯
# total_payment	請求額			integer	◯
# payment_method	支払方法			integer	◯
# status	注文ステータス			integer	◯
# created_at	登録日時			datetime	◯
# updated_at	更新日時			datetime	◯


#           orders GET    /orders(.:format)                                                                                 public/orders#index
#                 POST   /orders(.:format)                                                                                 public/orders#create
#       new_order GET    /orders/new(.:format)                                                                             public/orders#new
#           order GET    /orders/:id(.:format)                                                                             public/orders#show
#   orders_confirm POST   /orders/confirm(.:format)                                                                         public/orders#confirm
# orders_complete GET    /orders/complete(.:format)                                                                        public/orders#complete