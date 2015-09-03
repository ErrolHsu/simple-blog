module RenderHelper

	def	render_navbar
		render logged_in? ? 'layouts/user_nav' : 
	  							      'layouts/guest_nav' 
  end

  def render_dropdown_nav
  	render @user == current_user ? 'shared/dropdown_icon' : 
  																 'shared/dropdown_gravatar'
  end

  def blog_title
  	if logged_in?
  	  if  @user == current_user
  	  	title = "#{current_user.name}'s Blog"
  	  	path = user_path(current_user)
  	  else
  	  	title = "#{@user.name}'s Blog"
  	  	path = user_path(@user)
  	  end	
  	else 
  	  title =	"$&!$#%#$%"
  	  path = root_path  
  	end  
  return link_to title, path, id: "logo"
  end



end