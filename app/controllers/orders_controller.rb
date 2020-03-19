class OrdersController < ApplicationController
  def new
    @home = Home.find(params[:home_id])
    @order = Order.new
  end

  def create
    @home = Home.find(params[:home_id])
    @order = @home.orders.build(order_params)
    @order.user_id = current_user.id
    if @order.save
      @home.update status: "ordered"
      flash[:success] = "Order created!"
      redirect_to current_user
    else
      render "new"
    end
  end

  def destroy
    @home = Home.find(params[:home_id])
    @order = @home.orders.destroy(params[:id])
    @home.update status: "available"
    flash[:success] = "Order deleted"
    redirect_to current_user
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :phone_number, :checkin_time, :rental_period)
  end
end
