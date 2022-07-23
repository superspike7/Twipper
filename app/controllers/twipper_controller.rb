class TwipperController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    client = Twitter::API::Client.new(@user)
    
    @me = client.me
    @my_tweets = client.my_tweets
  end
end
