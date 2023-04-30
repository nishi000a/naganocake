class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)

    if @order_detail.making_status == "製作中"
      @order.update(status: 2)
    elsif @order.order_details.count ==  @order.order_details.where(making_status: "製作完了").count
      @order.update(status: 3)
    end
  end

  private

  def order_detail_params
      params.require(:order_detail).permit(:making_status)
  end

end