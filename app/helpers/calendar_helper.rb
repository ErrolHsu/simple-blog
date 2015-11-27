module CalendarHelper

	def calendar
		Calendar.to_normal_calendar(@date, @special_days, @user)
	end

	def each_day(state)
		if state[:mark]
			content_tag :div, class: "special-day #{state[:event]}" do
				content_tag :div, class: "mark-#{state[:mark]}", id: "mark-#{state[:today?]}" do
			    link_to state[:day], 
			    user_path(@user, query_date: "#{@date.year}-#{@date.month}-#{state[:day]}")
	  	  end 
		  end  	 
		else
			content_tag :div , class: "normal-days #{state[:event]}" do
				content_tag :div, state[:day], id: "mark-#{state[:today?]}"
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
