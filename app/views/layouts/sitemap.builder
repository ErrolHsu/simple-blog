xml.instruct!
xml.urlset(:xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9') do
  xml.url do
    xml.loc "#{@host}"
  end

  @users.each do |user|
  	xml.url do 
  		xml.loc "#{@host}#{user_path(user)}"
  	end	
  	user.articles.each do |article|
  		xml.url do
  		  xml.loc "#{@host}#{user_article_path(user, article)}"
  		end  
  	end	
  end		
end  
