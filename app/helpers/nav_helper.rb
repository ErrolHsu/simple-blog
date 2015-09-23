module NavHelper

  def render_nav_menu
    if logged_in?
      render 'layouts/nav_dropdown'
    end  
  end

  def render_blog_title
    if @user.nil? || @user.new_record?
      link_to root_path do
        content_tag(:div, "$&!$#%#$%", id: "logo")
      end  
    else  
      link_to user_path(@user) do
        content_tag(:div, @user.title, id: "logo")
      end 
    end	
  end

  def show_login_path
    if !logged_in?
      content_tag(:div, id: "nav-login") do
        link_to "Login", login_path
      end
    end  
  end

end
