# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter :verify_authenticity_token, :only => :create

  helper_method :current_user, :logined?

  def current_user
    @current_user || User.find_by_id(session[:user_id])
  end

  def logined?
    !!current_user
  end

  private

  def require_admin
    redirect_to root_path if !(logined? && current_user.admin?)
  end
end
