class TwipperController < ApplicationController
  before_action :require_user!
  
  def index
    client = Twitter::API::Client.new(current_user)
    
    @me = client.me
    @my_tweets = client.my_tweets
    @liked_tweets = client.liked_tweets
    @bookmarks = client.my_bookmarks
  end
end
