class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @home  = current_user.homes.build
      @feed_items = current_user.feed
    else
      @feed_items = get_admin.feed
    end
  end
  
  
  
end
