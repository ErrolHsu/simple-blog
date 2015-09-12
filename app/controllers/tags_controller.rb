class TagsController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@tags = @user.tags.all 
	end

	def show
		@user = User.find(params[:user_id])
		@tag = @user.tags.find(params[:id])
		@tags = @user.tags.all
		@articles = @tag.articles.all
	end

	def destroy
		@user = User.find(params[:user_id])
		@tag = @user.tags.find(params[:id])
		if @tag.destroy
			flash[:success] = "標籤已刪除"
			redirect_to user_tags_path
		end
	end
end


