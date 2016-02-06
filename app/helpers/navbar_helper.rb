module NavbarHelper

	def nav_li(name, options, icon, html_options={})
		active = request.fullpath == options ? "active" : nil
		content_tag :li, class: "#{active}" do 
			link_to options, html_options do 
				content_tag(:i, "", class: "fa fa-#{icon}") +
				content_tag(:span, name)
			end	
		end
	end

	def nav_li_gravatar(name, options, current_user, html_options={})
		active = request.fullpath == options ? "active" : nil
		content_tag :li, class: "#{active}", id: "nav-gravatar" do 
			link_to options, html_options do 
				content_tag(:span, gravatar_for(current_user, size: 20), class: "gravatar") +
				content_tag(:span, name)
			end	
		end		
	end
	
end
