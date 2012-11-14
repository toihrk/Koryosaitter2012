class WelcomeController < ApplicationController
  def index
    p session
    p current_user
    p signed_in?
    @toppage = ""
  end

  def about
  end

  ### Twitter Login Action ###
  def callback
    auth       = request.env["omniauth.auth"]
    uid        = auth["uid"]
    screenname = auth["info"]["nickname"]
    icon       = auth["info"]["image"]
    token      = auth["credentials"]["token"]
    secret     = auth["credentials"]["secret"]

    user = User.find_by_uid(uid) || User.new
    
    user.uid        = uid
    user.screenname = screenname
    user.icon       = icon
    user.token      = token
    user.secret     = secret
    user.save

    self.current_user=user
    redirect_to root_url, :flash => {:notice => "Signed in with @#{screenname}!"}
  end
  def signout
    session[:user_id] = nil
    redirect_to root_url, :flash => {:notice => "Signed out!"}
  end
  ###
end
