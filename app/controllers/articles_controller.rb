class ArticlesController < ApplicationController
	
	before_action :find_user

	before_action :can_write, except: [:index, :show]

	def index
		if current_user?(@user)
		  @articles = @user.articles.page(params[:page]).per(25)
		else  
		  @articles = @user.articles.published.page(params[:page]).per(25)
		end  
		@articles_by_year = @articles.group_by { |article| article.created_at.beginning_of_year}
		@tags = @user.tags.all 
	end

	def show
		@article = @user.articles.find(params[:id])
	end

	def new
		@article = current_user.articles.build
	end

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			flash[:success] = "文章已發佈"
			redirect_to user_path(current_user)
		else
			render :new
		end
	end

	def edit
		@article = @user.articles.includes(:tags).find(params[:id])
	end

	def update
		@article = current_user.articles.find(params[:id])
		if @article.update_attributes(article_params)
			flash[:success] = "編輯完成"
			redirect_to user_article_path(@user, @article)
		else
			render :edit
		end	
	end

	def to_recycling_bin
		@article = current_user.articles.find(params[:id])
		@article.to_trash
		flash[:success] = "移動 '#{@article.title}' 至垃圾桶"
		redirect_to request.referer
	end

	def return_state
		@article = current_user.articles.find(params[:id])
		hash = {'1' => '公眾', '2' => '私人', '3' => '草稿'}
		state = (@article.state - 10).to_s
		@article.return_state
		flash[:success] = "移動 '#{@article.title}' 至 '#{hash[state]}'"
		redirect_to request.referer
	end

	def multiple_destroy
		@articles = @user.articles.find_by_state([11, 12, 13])
		@articles.each { |article| article.delete_it }
		flash[:success] = "垃圾桶已清空"
		redirect_to request.referer
	end

	def destroy
		@article = current_user.articles.find(params[:id])
		@article.delete_it
		flash[:success] = "'#{@article.title}' 已刪除"
		redirect_to request.referer
	end


	private
		def find_user
			@user = User.find(params[:user_id])
		end


		def article_params
			params[:article].permit(:title, :content, :tag_names, {:tag_ids => []},
				:state)
		end

		def can_write
			@user = User.find(params[:user_id])
			unless current_user?(@user)
			  flash[:danger] = "無此權限"
			  redirect_to root_path 
			end  
		end
end
