# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  authorize_resource
	before_filter :get_tags

  helper_method :current_user, :logined?

  def current_user
    @current_user || User.find_by_id(session[:user_id])
  end

  def logined?
    !!current_user
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, flash: { error: exception.message }
  end

  protected
  def get_tags
    @tags = Tag.all
  end
end
