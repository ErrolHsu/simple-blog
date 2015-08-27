class SessionsController < ApplicationController

	def new
  end

  def create
  	@user = User.find_by(email: params[:session][:email])
  	if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      params[:session][:remember_me] == "1" ? remember_me(@user) : forget_me(@user)
  	  redirect_to user_path(@user)
  	else
  		flash.now[:danger] = "Email不存在或密碼錯誤."
  		render :new
  	end	
  end

  def destroy
    log_out if logged_in?

    redirect_to root_path
  end

end
