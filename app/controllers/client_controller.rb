class ClientController < ApplicationController
  before_filter :be_user

  def index
  end

  def post
    p current_user.token

    Twitter.configure do |config|
      config.consumer_key = Settings.twitter_key
      config.consumer_secret = Settings.twitter_secret
      config.oauth_token = current_user.token
      config.oauth_token_secret = current_user.secret
    end    
    
    Twitter.update(params[:tweet])
    render :text => "tweet"
  end

  def fav
    Twitter.configure do |config|
      config.consumer_key = Settings.twitter_key
      config.consumer_secret = Settings.twitter_secret
      config.oauth_token = current_user.token
      config.oauth_token_secret = current_user.secret
    end    
    p Twitter.favorite([params[:fav].to_i])
    render :text => "fav"
  end

  private
  def be_user
    if !signed_in?
      redirect_to root_path, :alert => "Please Sign in with Twitter."
    end
  end
end
