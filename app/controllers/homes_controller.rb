class HomesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :edit, :update]
  before_action :correct_user, only: :destroy

  def create
    @home = current_user.homes.build(home_params)
    if @home.save
      flash[:success] = "Home created!"
      redirect_to user_path(current_user)
    else
      @user = current_user
      @homes = Home.all
      render "users/show"
    end
  end

  def destroy
    @home.destroy
    flash[:success] = "Home deleted"
    redirect_to current_user
  end

  def edit
    @home = Home.find(params[:id])
  end

  def update
    @home = Home.find(params[:id])
    if @home.update_attributes(home_params)
      flash[:success] = "Home updated"
      redirect_to user_path(current_user)
    else
      render "edit"
    end
  end

  private

  def home_params
    params.require(:home).permit(:name, :status, :number_floors, :full_price, :picture)
  end

  def correct_user
    @home = current_user.homes.find_by(id: params[:id])
    redirect_to root_url if @home.nil?
  end
end
