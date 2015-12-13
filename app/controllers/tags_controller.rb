class TagsController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@tags = @user.tags.all 
	end

	def show
		@user = User.find(params[:user_id])
		@tags = @user.tags.all
		@tag = @user.tags.find(params[:id])
		if current_user?(@user)
			@articles = @tag.articles
		else	
			@articles =  @tag.articles.published
		end	
	end

	def destroy
		@user = User.find(params[:user_id])
		@tag = @user.tags.find(params[:id])
		if @tag.destroy
			flash[:success] = "標籤已刪除"
			redirect_to manage_user_path(current_user)
		end
	end
end


