require 'extension/calendar.rb'

class UsersController < ApplicationController

	before_action :find_user, except: [:index, :new, :create]
	before_action :correct_user, only: [:edit, :update, :manage]

	def index
		@users = User.all
		@user = current_user
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in(@user)
			flash[:success] = "修改或完善個人資料"
			redirect_to edit_user_path(@user)
		else
			render :new
		end		
	end

	def show
		@date = params[:year] ? Time.zone.local(params[:year], params[:month], params[:day]) : Time.zone.now
		@special_days = @user.articles.special_days(@date)
		@tags = @user.tags.all
		@articles = @user.articles.in_this_range(@date, params[:month], params[:day]).page(params[:page]).per(5)
	end

	def edit
	end

	def update
		  if @user.update_attributes (user_params)
				flash[:success] = "更新已儲存"
		    redirect_to user_path(current_user)
		  else
		  	render :edit
		  end	
	end

	def about_me
	end	

	def manage
		if params[:state].nil?
			@select_articles = @user.articles.all
		else	
		  @select_articles = @user.articles.where(state: params[:state])
		end  
		@articles = @select_articles.page(params[:page]).per(25)
		@articles_by_year = @articles.group_by { |article| article.created_at.beginning_of_year}
		@tags = @user.tags.all
	end

	private
		def user_params
			params[:user].permit(:name, :email, :password, :password_confirmation,
													 :title, :about_me, :gravatar)
		end

		def find_user
			@user = User.find(params[:id])
		end

    def correct_user
    	@user = User.find(params[:id])
    	unless current_user?(@user)
    		flash[:danger] = "無此權限"
    		redirect_to root_path
    	end
    end

end



