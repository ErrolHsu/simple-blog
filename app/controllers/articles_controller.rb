class ArticlesController < ApplicationController

	def index
		@articles = current_user.articles.all
	end

	def new
		@article = current_user.articles.build
	end

	def show
		@user = User.find(params[:user_id])
		@article = @user.articles.find(params[:id])
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

	def edit
		@article = current_user.articles.find(params[:id])
	end

	def update
		@article = current_user.articles.find(params[:id])
		if @article.update_attributes(article_params)
			flash[:success] = "編輯成功"
			redirect_to user_path(current_user)
		else
			render :edit
		end	
	end

	def destroy
		@article = current_user.articles.find(params[:id])
		if @article.destroy
			flash[:success] = "文章已刪除"
			redirect_to user_articles_path(current_user)
		else
			flash[:danger] = "刪除失敗"
			redirect_to user_articles_path(current_user)
		end		
	end


	def url_options
		{ user_id: current_user }.merge(super)
	end
	

	private

		def article_params
			params[:article].permit(:title, :content)
		end
end
