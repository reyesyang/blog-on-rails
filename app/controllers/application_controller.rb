class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
	before_filter :get_tags
	before_filter :get_current_version

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

  def get_current_version
    @latest_evolution = Evolution.first
    @current_version = @latest_evolution ? @latest_evolution.version : '11.07.17.01'
  end
end
