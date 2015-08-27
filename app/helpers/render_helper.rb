module RenderHelper

	def	render_navbar
		render logged_in? ? 'layouts/is_logged_in_nav' : 
	  							      'layouts/is_not_log_in_nav' 
  end


end