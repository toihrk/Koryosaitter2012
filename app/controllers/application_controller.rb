class ApplicationController < ActionController::Base
  helper_method :current_user, :signed_in?
  protect_from_forgery
  include Jpmobile::ViewSelector

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def signed_in?
    !!current_user
  end

end
