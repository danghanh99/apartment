class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @home  = current_user.homes.build
      @feed_items = current_user.feed
    else
      @feed_items = get_admin.feed
    end
  end
  
  def help
  end

  def index  
    if params[:search].blank?  
      redirect_to(root_path, alert: "Empty field!") and return  
    else  
      @parameter = params[:search].downcase  
      @results = Home.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")  
    end  
  end
end
