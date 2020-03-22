class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

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

  def approved
    @order = Order.find_by(id: params[:order_id])
    @home = Home.find_by(id: @order.home_id)
    @home.update status: "rented"
    @order.update order_status: "approved"
    flash[:success] = "approved Order"
    redirect_to orders_path
  end

  def deny
    @order = Order.find_by(id: params[:order_id])
    @home = Home.find_by(id: @order.home_id)
    @home.update status: "available"
    @order.update order_status: "deny"
    flash[:danger] = "deny Order"
    redirect_to orders_path
  end

  private

  def order_params
    params[:order][:checkin_time] = DateTime.strptime(params[:order][:checkin_time], "%m/%d/%Y %l:%M %p")
    params.require(:order).permit(:name, :address, :phone_number, :checkin_time, :rental_period)
  end
end
