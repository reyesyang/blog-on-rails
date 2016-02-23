class SessionsController < ApplicationController
  def create
  end

  def destroy
    session[:email] = nil
    cookies.delete :email
    cookies.delete :admin

    respond_to do |format|
      format.json { render nothing: true, status: 204 }
    end
  end
end
