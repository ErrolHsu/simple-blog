module UsersHelper
	
	def gravatar_for(user, options = { size:80 })
		user = user.gravatar?	? user : User.first		
	  gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	  size = options[:size]
	  gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	  image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def gravatar_now
  	if current_user.gravatar?
  		gravatar_for(current_user)
  	else
  		gravatar_for(User.first)
  	end	
  end

  def blog_title_now
 		if current_user.title.blank?
 			"#{current_user.name}'s Blog"
 		else
 			current_user.title
 		end		
  end


  def correct_icon_link
  	if correct_user?
  		link_title = "NEW ARTICLE"
  		path = new_user_article_path(@user)
  		style = "glyphicon glyphicon-plus"
  	else
  		link_title = "Blog Archive"
  		path = user_articles_path(@user)
  		style = "glyphicon glyphicon-book"
  	end
  	return link_to link_title, path, class: style
  end

end
