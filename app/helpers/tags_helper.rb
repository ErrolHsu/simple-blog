module TagsHelper

  def user_tags_info(tags)
    tags.map { |tag| link_to "#{tag.name}(#{tag.articles.size})", 
                   user_tag_path(@user, tag)}.join(", ")
  end

  def tag_list(tags)
    @tag_list	= tags.map do |tag|
    		    link_to user_tag_path(@user,tag) do
    			    content_tag(:span, tag.name, class: "tag_list")
    		    end	
    	    end
    @tag_list.join(" ")	    
  end

end
