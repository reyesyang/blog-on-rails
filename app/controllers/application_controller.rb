class ApplicationController < ActionController::Base
  before_filter :authorize
	before_filter :get_tags
  protect_from_forgery

  protected
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, :notice => "Please login as admin"
      end
    end

		def get_tags
			@tags = Tag.all
		end
end
