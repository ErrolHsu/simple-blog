module ArticlesHelper

	def article_state(article)
		if current_user?(@user)
			hash = {'1' => '公眾', '2' => '私人', '3' => '草稿', '11' => '公眾', '12' => '私人', '13' => '草稿'}
			content_tag :span, hash[article.state.to_s], class: "state-#{article.state}"
		end
	end

	def article_option(article)
		if request.fullpath == manage_user_path(@user) || [1, 2, 3].include?(params[:state].to_i)
			link_to("移至垃圾桶", to_recycling_bin_user_article_path(@user, article), 
			  method: 'post', class: "delete-link" ) +
			content_tag(:span, "---", class: "link-sym") +
			link_to("編輯", edit_user_article_path(@user, article), class: "edit-link")
		elsif params[:state] == "trash"
			link_to("永久刪除 !", user_article_path(@user, article), 
				method: 'delete', data: {confirm: "確定刪除文章 '#{article.title}' ?"}, class: "delete-link") +
			content_tag(:span, "---", class: "link-sym") +
			link_to("復原", undone_user_article_path(@user, article), method: 'post', class: "edit-link")
		end	
	end

	def related_articles(article)
		if article.present?
			link_to article.title, user_article_path(@user, article)
		end	
	end



end