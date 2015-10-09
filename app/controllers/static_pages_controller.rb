class StaticPagesController < ApplicationController

	def home
		if !current_user.nil?
			redirect_to user_path(current_user)
		end	
	end


	def sitemap
    @host = request.protocol + request.host
    @users = User.all
    respond_to do |format|
      format.xml 
    end
  end
	
end
