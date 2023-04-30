class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
  end

  def update
  	@order = Order.find(params[:id])
  	@order_details = @order.order_details
  	@order.update(order_params)

    if @order.status == "入金確認"
      @order_details.update(status: 1)
    end
      redirect_to  admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end



# id	注文ID	◯		integer
# customer_id	会員ID		◯	integer
# postal_code	配送先郵便番号			string
# address	配送先住所			string
# name	配送先宛名			string
# shipping_cost	送料			integer
# total_payment	請求額			integer
# payment_method	支払方法			integer
# status	注文ステータス			integer
# created_at	登録日時			datetime
# updated_at	更新日時			datetime


                      #       admin_orders GET    /admin/orders(.:format)                                                                           admin/orders#index
                      #       admin_order GET    /admin/orders/:id(.:format)                                                                       admin/orders#show
                      #                   PATCH  /admin/orders/:id(.:format)                                                                       admin/orders#update
                      #                   PUT    /admin/orders/:id(.:format)                                                                       admin/orders#update
                      # admin_order_detail PATCH  /admin/order_details/:id(.:format)                                                                admin/order_details#update
                      #                   PUT    /admin/order_details/:id(.:format)                                                                admin/order_details#update