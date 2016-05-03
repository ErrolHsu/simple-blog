class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  
  include SessionsHelper

  helper_method :current_user, :current_user?



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

	def current_user?(user)
		user == current_user
	end

	private 

		def find_user
			@user = User.find(params[:user_id])
		end

		def set_side_bar
			@query_date = params[:query_date] ? params[:query_date].split("-").map(&:to_i) : []
	
			@date = params[:query_date] ? Time.zone.local(*@query_date) : Time.zone.now
			@special_days = @user.special_days(@date)
			@tags = @user.tags.all	
			@todo_event = @user.todo_events.build	
		end

		def find_recent_articles
    	@recent_articles = @user.articles.published.limit(5).pluck(:created_at, :title, :id)
    end


end
