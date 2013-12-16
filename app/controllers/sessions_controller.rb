class SessionsController < ApplicationController
  def create
    omniauth = request.env['omniauth.auth']
    auth = Authorization.where(provider: omniauth['provider'], uid: omniauth['uid']).first_or_create do |auth|
      auth.user = User.where(email: omniauth[:info][:email]).first_or_initialize(name: omniauth[:info][:name],
                                                                                 image_url: omniauth[:info][:image])
    end
    
    session[:user_id] = auth.user.id
    redirect_to root_path
  end

  def logout
    reset_session
    redirect_to :root 
  end
end
