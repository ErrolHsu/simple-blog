module ApplicationHelper


	def	render_navbar
		if logged_in?
			render 'layouts/user_nav'
		else
			render 'layouts/not_login_nav'
		end		
  end

end
