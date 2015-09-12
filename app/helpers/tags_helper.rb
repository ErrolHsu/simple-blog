module TagsHelper

  def user_tags_info(tags)
    tags.map { |tag| link_to "#{tag.name}(#{tag.articles.size})", 
                   user_tag_path(tag)}.join(", ")
  end

  def article_tags(tags)
  	tags.map { |tag| link_to tag.name, user_tag_path(tag)}.join(", ")
  end

end
