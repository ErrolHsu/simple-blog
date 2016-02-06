module UsersHelper

  def active_link(name, options, html_options = {})
    active = request.fullpath == options ? " #{html_options[:active]}" : " nil"
    if  html_options[:class]
      html_options[:class] += active
    else
      html_options[:class] = active
    end    
    link_to name, options, html_options
  end

  def trash
    options = manage_user_path(@user, state: "trash") 
    active = request.original_fullpath == options ? "active-1" : "not_active"
    link_to options do
      content_tag :div, class: "recycling-bin #{active}" do
        content_tag(:span, "", class: "glyphicon glyphicon-trash") +
        content_tag(:span, "Trash")
      end  
    end  
  end



end
