class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = I18n.t(:login_message)
      redirect_to login_url
    end
  end
end
