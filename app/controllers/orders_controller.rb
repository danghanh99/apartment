class OrdersController < ApplicationController
  def new
    @home = Home.find(params[:home_id])
    @order = Order.new
  end

  def create
    @home = Home.find(params[:home_id])
    @order = @home.orders.build(order_params)
    @order.user_id = current_user.id
    @order.order_status = "requesting"
    if @order.save
      @home.update status: "ordered"
      @home.save
      flash[:success] = "Order created!"
      redirect_to current_user
    else
      flash[:danger] = "Order create failed!"
      render "new"
    end
  end

  def destroy
    @home = Home.find(params[:home_id])
    @order = @home.orders.find(params[:id])
    @order.destroy
    @home.update status: "available"
    @home.save
    flash[:success] = "Order deleted"
    redirect_to current_user
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :phone_number, :checkin_time, :rental_period)
  end
end
