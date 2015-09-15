module NavHelper

  def render_nav_menu
    if logged_in?
      render 'shared/nav_dropdown'
    end  
  end

  def render_blog_title
    if @user && @user.id
    	title = @user.title
      path = user_path(@user)
    else  
      title = "$&!$#%#$%"
      path = root_path
    end	
    link_to title, path
  end

end
