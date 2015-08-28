class ArticlesController < ApplicationController

	def new
		@article = current_user.articles.build
	end

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			flash[:success] = "success"
			redirect_to user_path(current_user)
		else
			render :new
		end
	end

	

	private

		def article_params
			params[:article].permit(:title, :content)
		end
end
