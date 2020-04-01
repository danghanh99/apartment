class RoomsController < ApplicationController
  def new
    @home = Home.find(params[:home_id])
    @room = Room.new
  end

  def create
    @home = Home.find(params[:home_id])
    @room = @home.rooms.build(room_params)
    @room.user_id = current_user.id
    if @room.save
      flash[:success] = "room created!"
      redirect_to home_url(@home)
    else
      @rooms = Room.all
      render "homes/show"
    end
  end

  def detail
    if admin?
      @room = Room.find(params[:room_id])
      @orders = @room.orders
    end
  end

  def destroy
    @home = Home.find(params[:home_id])
    @room = @home.rooms.destroy(params[:id])
    flash[:success] = "room deleted!"
    redirect_to home_url(@home)
  end

  def edit
    @home = Home.find(params[:home_id])
    @room = @home.rooms.find(params[:id])
  end

  def update
    @home = Home.find(params[:home_id])
    @room = @home.rooms.find(params[:id])
    if @room.update_attributes(room_params)
      flash[:success] = "room updated"
      redirect_to home_url(@home)
    else
      render "edit"
    end
  end

  private

  def room_params
    params.require(:room).permit(:length, :width, :height, :number_room, :price, :status, :price_unit, :area)
  end
end
