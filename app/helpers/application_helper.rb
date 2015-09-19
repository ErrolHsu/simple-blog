module ApplicationHelper
  
  def full_title(page_title= "")
    if @user && @user.id
      if page_title.blank?
        @user.title
      else  
        "#{@user.title} - #{page_title}"
      end  
    else
      "$&!$#%#$%"
    end   
  end


  def gravatar_for(user, size: 80, id: "")
    user = user.gravatar? ? user : User.first   
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, id: id)
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


  def show?(condition=true, tag, message, style: "")
    if condition
      content_tag(:tag, "---", class: style)
    end
  end

end
