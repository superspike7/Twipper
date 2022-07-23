class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  
  def logout
    session[:user_id] = nil
    redirect_to "/"
  end
  
  def create
    user_info = request.env['omniauth.auth']

    @user = User.find_by(twitter_id: user_info.uid)
    if @user.nil?
      @user = User.create!(
        twitter_id: user_info.uid,
        nickname: user_info.info.nickname,
        name: user_info.info.name,
        token: user_info.credentials.token,
        refresh_token: user_info.credentials.refresh_token,
        expires_at: Time.at(user_info.credentials.expires_at).to_datetime
      )
    else
      @user.update(
        token: user_info.credentials.token,
        refresh_token: user_info.credentials.refresh_token,
        expires_at: Time.at(user_info.credentials.expires_at).to_datetime
      )
    end

    session[:user_id] = @user.id

    redirect_to '/twipper' 
  end
end
