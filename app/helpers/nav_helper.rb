module NavHelper

	def	render_navbar
		render logged_in? ? 'layouts/user_nav' : 
	  							      'layouts/guest_nav' 
  end

  def render_dropdown_nav
  	render @user == current_user ? 'shared/dropdown_icon' : 
  																 'shared/dropdown_gravatar'
  end

  def user_blog_title(title: "#{@user.name}'s Blog")
    if  @user == current_user 
    	title = current_user.title if !@user.title.blank?
    	path = user_path(current_user)
    else
    	title = @user.title if !@user.title.blank?
    	path = user_path(@user)
    end	
    return link_to title, path, id: "logo"
  end

  def guest_blog_title
  	if @user.nil?
  		title =	"$&!$#%#$%"
  	  path = root_path
  	else 
  		if params[:id]
  			title = !@user.title.blank? ? @user.title : "#{@user.name}'s Blog"
    		path = user_path(@user)
      elsif params[:user_id]
				title = !@user.title.blank? ? @user.title : "#{@user.name}'s Blog"
    		path = user_path(@user)
      else	
        title =	"$&!$#%#$%"
  	    path = root_path
  	  end  
  	end
  	return link_to title, path, id: "logo"
  end



end