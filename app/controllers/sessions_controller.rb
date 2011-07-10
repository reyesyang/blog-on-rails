class SessionsController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]

  def new
  end

  def create
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, :alter => "Invalid user or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to articles_url, :notice => "Logged our"
  end

end
