module SessionsHelper
	
	def log_in(user)
		session[:user_id] = user.id
	end

	def logged_in?
		current_user.present?
	end

	def log_out
		forget_me(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	def remember_me(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	def forget_me(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end



end
