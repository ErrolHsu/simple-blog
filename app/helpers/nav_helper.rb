module NavHelper

  def render_blog_title(option = nil)
    if @user.nil? || @user.new_record?
      link_to root_path do
        content_tag(:div, "$&!$#%#$%", option)
      end  
    else  
      link_to user_path(@user) do
        content_tag(:div, @user.title, option)
      end 
    end	
  end


end
