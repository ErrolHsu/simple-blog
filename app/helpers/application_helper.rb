module ApplicationHelper
  
  def full_title(page_title= "")
    base_title = "s20a3264"
    if page_title.empty?
      base_title
    else
      page_title + "  <<  " + base_title
    end
  end


  def gravatar_for(user, options = { size: 80 })
    user = user.gravatar? ? user : User.first   
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

  def show_link(condition=true, title, path, method: "get", data: nil, style: "nornal" )
  	if condition
  		link_to title, path, method: method, data: data, class: style
  	end	 
  end

end
