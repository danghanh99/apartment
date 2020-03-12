class StaticPagesController < ApplicationController
  def home
    @feed_items = Home.all
  end

  def help
  end
end
