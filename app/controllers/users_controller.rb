class UsersController < ApplicationController

	def index
		@user = User.all
	end


	def new
		@user = User.new
	end

	
	def create
		@user = User.new(user_params)
		if @user.save
			log_in(@user)
			flash[:success] = "完善個人資料"
			redirect_to edit_user_path(@user)
		else
			render :new
		end		
	end


	def show
		@user = User.find(params[:id])
		@articles = @user.articles.page(params[:page]).per(3)
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		  if @user.update_attributes (user_params)
				flash[:success] = "帳戶設定已更新"
		    redirect_to user_path(current_user)
		  else
		  	render :edit
		  end	
	end


	private

		def user_params
			params[:user].permit(:name, :email, :password, :password_confirmation,:title, :about_me)
		end


end
