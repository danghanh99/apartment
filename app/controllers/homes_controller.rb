class HomesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @home = current_user.homes.build(home_params)
    if @home.save
      flash[:success] = "Home created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @home.destroy
    flash[:success] = "Home deleted"
    redirect_to  root_url 
  end

  def edit
    @home = Home.find(params[:id])
    render 'edit'
  end  
  
  def update  
    @home = Home.find(params[:id])
    if @home.update_attributes(home_params)
    redirect_to root_url
  end
end

  private

    def home_params
      params.require(:home).permit(:name, :status, :number_floors, :price, :picture)
    end

    def correct_user
      @home = current_user.homes.find_by(id: params[:id])
      redirect_to root_url if @home.nil?
    end
end