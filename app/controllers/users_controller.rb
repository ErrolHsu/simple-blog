class UsersController < ApplicationController

	before_action :logged_in_user, only: [:edit, :update]
	before_action :can_edit, only: [:edit, :update]

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
		@user = User.find(params[:id])
		@articles = @user.articles.page(params[:page]).per(5)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		  if @user.update_attributes (user_params)
				flash[:success] = "更新已儲存"
		    redirect_to user_path(current_user)
		  else
		  	render :edit
		  end	
	end


	private

		def user_params
			params[:user].permit(:name, :email, :password, :password_confirmation,
													 :title, :about_me, :gravatar)
		end


		def logged_in_user
			unless logged_in?
				flash[:danger] = "請先登入"
				redirect_to login_path
			end	
		end

		def can_edit
			@user = User.find(params[:id])
			unless current_user?(@user)
				flash[:danger] = "無此權限"
				redirect_to root_path
			end
		end

end
