class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :index, :destroy]
  before_action :logged_in_admin, only: [:deny, :approved]

  def index
    @orders = current_user.orders
    @orders = Order.all if current_user.admin?
  end

  def new
    @home = Home.find(params[:home_id])
    @order = Order.new
  end

  def requesting_extension
    @order = Order.find_by(id: params[:order_id])
    @home = Home.find_by(id: @order.home_id)
  end

  def update
    @order = Order.find_by(id: params[:id])
    if @order.update_attributes(order_params)
      @order.update order_status: "requesting extension"
      flash[:success] = "requesting extension Order"
      redirect_to orders_path
    else
      render "requesting_extension"
    end
  end

  def create
    @home = Home.find(params[:home_id])
    @order = @home.orders.build(order_params)
    @order.user_id = current_user.id
    if @order.save
      @home.update status: "ordered"
      flash[:success] = "Order created!"
      redirect_to orders_path
    else
      render "new"
    end
  end

  def destroy
    @home = Home.find(params[:home_id])
    @order = @home.orders.find(params[:id])
    if @order.order_status == "requesting" || @order.order_status == "deny" || @order.order_status == "finished"
      @order.destroy
      @home.update status: "available"
      flash[:success] = "Order deleted"
      redirect_to orders_path
    else
      flash[:danger] = "Request deny , please contact to landlord"
      redirect_to orders_path
    end
  end

  def approved_extension
    @order = Order.find_by(id: params[:order_id])
    @home = Home.find_by(id: @order.home_id)
    @order.update order_status: "approved extension"
    flash[:success] = "approved extension Order"
    redirect_to orders_path
  end

  def approved
    @order = Order.find_by(id: params[:order_id])
    @home = Home.find_by(id: @order.home_id)
    @home.update status: "rented"
    @order.update order_status: "approved"
    flash[:success] = "approved Order"
    redirect_to orders_path
  end

  def deny_extension
    @order = Order.find_by(id: params[:order_id])
    @home = Home.find_by(id: @order.home_id)
    @order.update order_status: "deny extension"
    flash[:danger] = "deny extension Order"
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
    params.require(:order).permit(:checkin_time, :rental_period)
  end
end
