module NavHelper

  def render_nav_menu
    if logged_in?
      render 'layouts/nav_dropdown'
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

  def show_login_path
    if !logged_in?
      content_tag(:div, id: "nav-login") do
        link_to "Login", login_path
      end
    end  
  end

end
