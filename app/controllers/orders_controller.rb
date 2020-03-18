class OrdersController < ApplicationController
  def new
    @home = Home.find(params[:home_id])
    @order = Order.new
  end

  private

  def order_params
    params.require(:order).permit(:checkin_time, :rental_period, :order_status)
  end
end
