module CalendarHelper

	def calendar
		settings = @user.settings
		if current_user?(@user)
		  Calendar.user_calendar(@date, @special_days, settings)
		else
			Calendar.visitor_calendar(@date, @special_days, settings)
		end	
	end

	def each_day(hash)
		if hash[:article_day]
			query_date = "#{@date.year}-#{@date.month}-#{hash[:day]}"
			active = params[:query_date] && params[:query_date] == query_date ? :active : nil

			content_tag :div, class: "article-day #{hash[:event]} #{hash[:color]}" do
				content_tag :div, class: "#{hash[:today]} #{active}" do
			    link_to hash[:day], 
			    user_path(@user, query_date: query_date)
	  	  end 
		  end  	 
		else
			content_tag :div , class: "no-article-days #{hash[:event]} #{hash[:color]}" do
				content_tag :div, hash[:day], class: "#{hash[:today]}"
			end	
		end	
	end


	def previous_and_next_month
		date = @date.prev_month
		previous_month = date.strftime("%b")
		date2 = @date.next_month
	  next_month = date2.strftime("%b")
		link_to("《 #{previous_month}", user_path(@user, query_date: "#{date.year}-#{date.month}"), id: "previous_month") +
		link_to( "#{next_month} 》", user_path(@user,  query_date: "#{date2.year}-#{date2.month}"), id: "next_month")
	end
end
