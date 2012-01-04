# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
	before_filter :get_tags

  helper_method :current_user

  def current_user
    @current_user
  end

  protected
  def authorize
    @current_user = User.find_by_id(session[:user_id])

    unless @current_user
      redirect_to login_url
    end
  end

  def get_tags
    @tags = Tag.all
  end
end
