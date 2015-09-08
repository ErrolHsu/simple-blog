module ApplicationHelper
  
  def full_title(page_title= "")
    base_title = "s20a3264"
    if page_title.empty?
      base_title
    else
      page_title + "  <<  " + base_title
    end
  end

  def show_link(condition=true, title, path, method: "get", data: nil, style: "nornal" )
  	if condition
  		link_to title, path, method: method, data: data, class: style
  	end	 
  end

end
