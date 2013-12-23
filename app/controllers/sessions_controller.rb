class SessionsController < ApplicationController
  def create
    require 'net/http'

    uri = URI('https://verifier.login.persona.org/verify')
    response = Net::HTTP.post_form(uri,
                                   assertion: params[:assertion],
                                   audience: APP_CONFIG['origin'])
    
    result = case response
             when Net::HTTPSuccess
               JSON.parse(response.body, symbolize_names: true)
             else
               { status: failure, reason: 'Persona verifier service error' }
             end

    logged_in = result[:status] == 'okay'
    if logged_in
      session[:email] = result[:email]
      cookies[:email] = result[:email]
    end

    respond_to do |format|
      format.json { render json: result, status: logged_in ? 200 : 403  }
    end
  end

  def destroy 
    session[:email] = nil
    cookies.delete :email

    respond_to do |format|
      format.json { render nothing: true, status: 204 }
    end
  end
end
