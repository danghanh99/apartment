class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :index, :destroy]
  before_action :logged_in_admin, only: [:deny, :approve]

  def index
    @orders = Order.search(params, current_user.id) if params.present?
  end

  def new_extension
    @order_parent = Order.find(params[:order_id])
    if @order_parent.approved?
      @home = Home.find(@order_parent.home_id) if @order_parent.home_id.present?
      @room = Room.find(@order_parent.room_id) if @order_parent.room_id.present?
      @current_object = @home.present? ? @home : @room
      @order = Order.new
    else
      flash[:danger] = "Order failed!"
      redirect_to orders_path
    end
  end

  def create_extension
    @order_parent = Order.find(params[:order_id])
    @home = Home.find(@order_parent.home_id) if @order_parent.home_id.present?
    @room = Room.find(@order_parent.room_id) if @order_parent.room_id.present?
    @current_object = @home.present? ? @home : @room
    @order = @current_object.orders.build(create_extension_params) if @current_object.present?
    @order.user_id = @order_parent.user_id
    @order.checkin_time = @order_parent.checkin_time
    @order.order_extion!
    @order.relation = @order_parent.id
    if @order.save
      flash[:success] = "Order created!"
      redirect_to orders_path
    else
      render "new_extension"
    end
  end

  def new
    @home = Home.find(params[:home_id]) if params[:home_id].present?
    @room = Room.find(params[:room_id]) if params[:room_id].present?
    @order = Order.new
  end

  def create
    @home = Home.find(params[:home_id]) if params[:home_id].present?
    @room = Room.find(params[:room_id]) if params[:room_id].present?
    @current_object = @home.present? ? @home : @room
    if @current_object.available? || @current_object.ordered?
      @order = @current_object.orders.build(order_params) if @current_object.present?
      @order.user_id = current_user.id
      @order.order_new!
      if @order.save
        @home.ordered! if @home.present?
        @room.ordered! if @room.present?
        flash[:success] = "Order created!"
        redirect_to orders_path
      else
        render "new"
      end
    else
      flash[:danger] = "Order failed!  #{@current_object.type_name} rented"
      redirect_to orders_path
    end
  end

  def edit
    @order = Order.find_by(id: params[:id])
    @home = @order.home if @order.home_id.present?
    @room = @order.room if @order.room_id.present?
    @args = @home.present? ? @home : @room
    unless @order.requesting? || @order.requesting_extension?
      flash[:danger] = "Request deny , please contact to landlord"
      redirect_to orders_path
    end
  end

  def update
    @order = Order.find_by(id: params[:id])
    if @order.update_attributes(order_params)
      flash[:success] = "editted Order"
      redirect_to orders_path
    else
      render "edit"
    end
  end

  def cancel
    @order = Order.new
    check = false
    @order = Order.cancel(params, check)
    check ? flash[:success] = "Order cancelled" : flash[:danger] = "Request deny , please contact to landlord"
    redirect_to orders_path
  end

  def finish
    @order = Order.new
    check = false
    @order = Order.finish(params, check)
    check ? flash[:success] = "Order finished" : flash[:danger] = "Request deny , please contact to landlord"
    redirect_to orders_path
  end

  def approve
    @order = Order.new
    @order = Order.approve(params)
    @order.approved? ? flash[:success] = "approved Order" : flash[:danger] = "Request deny , please contact to landlord"
    redirect_to orders_path
  end

  def deny
    @order = Order.new
    @order = Order.deny(params)
    @order.denied? ? flash[:success] = "denied Order" : flash[:danger] = "Request deny , please contact to landlord"
    redirect_to orders_path
  end

  private

  def order_params
    params[:order][:checkin_time] = DateTime.strptime(params[:order][:checkin_time], "%m/%d/%Y %l:%M %p")
    params.require(:order).permit(:checkin_time, :rental_period)
  end

  def create_extension_params
    params.require(:order).permit(:rental_period)
  end
end
