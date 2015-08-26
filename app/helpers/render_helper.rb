module RenderHelper

	def	render_navbar
		if logged_in?
			render 'layouts/logged_in_nav'
		else
			render 'layouts/not_log_in_nav'
		end		
  end


end