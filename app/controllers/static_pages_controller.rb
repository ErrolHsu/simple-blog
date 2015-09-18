class StaticPagesController < ApplicationController

	def home
		if !current_user.nil?
			redirect_to user_path(current_user)
		end	
	end
	
end
