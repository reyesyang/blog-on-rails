class SessionsController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]

  def new
  end

  def create
    user = User.find_by_name params[:name]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, :alter => "Invalid user or password"
    end
  end

  def destroy
    reset_session
    redirect_to articles_url, :notice => "Logged our"
  end
end
