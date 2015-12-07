module UsersHelper

  def link_to_box(name = nil, path = nil, html_options = nil)
    active = request.original_fullpath == path ? " link_active" : " not_active"
    if  html_options[:class]
      html_options[:class] += active
    else
      html_options[:class] = active
    end    
    link_to path do
      content_tag :div, name, html_options
    end
  end

  def trash
    path = manage_user_path(@user, state: 4) 
    active = request.original_fullpath == path ? "link_active" : "not_active"
    link_to path do
      content_tag :div, class: "recycling-bin #{active}" do
        content_tag(:span, "", class: "glyphicon glyphicon-trash") +
        content_tag(:span, "Trash")
      end  
    end  
  end

end
