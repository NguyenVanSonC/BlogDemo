class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "logged"
    redirect_to login_url
  end

  def valid_object? object
    render "layouts/404" unless object
  end
end
