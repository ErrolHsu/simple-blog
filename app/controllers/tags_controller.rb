class TagsController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@tags = @user.tags.all 
	end

	def show
		@user = User.find(params[:user_id])
		@tag = @user.tags.find(params[:id])
		@articles = @tag.articles.all
	end
end
