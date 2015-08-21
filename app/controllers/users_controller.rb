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
			flash[:success] = "歡迎~"
			redirect_to user_path(@user)
		else
			render :new
		end		
	end


	def show
		@user = User.find(params[:id])
	end





	private

		def user_params
			params[:user].permit(:name, :email, :password, :password_confirmation)
		end
end
