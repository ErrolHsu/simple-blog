module UsersHelper
	
  def correct_icon_link
  	if current_user?(@user)
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
