class ArticlesController < ApplicationController

	def new
		@article = current_user.articles.build
	end

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			
			redirect_to user_path(current_user)
		else
			render :new
		end		
	end

	def url_options
		{ user_id: params[:user_id] }.merge(super)
	end	

	private

		def article_params
			params[:article].permit(:title, :content)
		end
end
