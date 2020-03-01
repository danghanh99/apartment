class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @home  = current_user.homes.build
      @feed_items = current_user.feed
    end
  end

  def help
  end
end
