class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  
  include SessionsHelper

  helper_method :current_user



  def current_user
  	if session[:user_id].present?
		  @current_user ||= User.find_by(id: session[:user_id])
		elsif cookies[:user_id].present?
			user = User.find_by(id: cookies.signed[:user_id])
			if user && user.authenticated?(cookies[:remember_token])
				log_in(user)
			  @current_user = user
			end
		else
			@current_user = nil	
		end	  
	end

end
