# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= session[:email] ? User.new(session[:email]) : nil
  end

  def logged_in?
    !!current_user
  end

  private

  def require_admin
    redirect_to root_path if !(logged_in? && current_user.admin?)
  end
end
