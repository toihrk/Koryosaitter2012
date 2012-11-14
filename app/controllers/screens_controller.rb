class ScreensController < ApplicationController
  before_filter :auth, :except => [ :client ]

  def main
  end

  def sub
  end

  def admin
  end

  def client
    if signed_in?
    else
      redirect_to root_path, :alert => "Please Sign in with Twitter."
    end
  end

  private
  def auth
    authenticate_or_request_with_http_basic do |user, pass|
      user == 'admin' && pass == 'iasoyrok'
    end
  end  
end
