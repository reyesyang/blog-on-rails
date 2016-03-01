class SessionsController < ApplicationController
  def create
    email = auth_hash[:info][:email]

    if email == 'reyes.yang@gmail.com'
      session[:email] = email
      cookies[:admin] = true
    end

    redirect_to root_path
  end

  def destroy
    session[:email] = nil
    cookies.delete :admin

    redirect_to root_path, notice: '成功退出'
  end

  private
    def auth_hash
      request.env['omniauth.auth']
    end
end
