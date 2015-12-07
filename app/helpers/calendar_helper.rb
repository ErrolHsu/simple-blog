module CalendarHelper

	def calendar
		settings = @user.settings
		if current_user?(@user)
		  Calendar.user_calendar(@date, @special_days, settings)
		else
			Calendar.visitor_calendar(@date, @special_days, settings)
		end	
	end

	def number_cell(hash)
		query_date = "#{@date.year}-#{@date.month}-#{hash[:day]}"
		active = params[:query_date] && params[:query_date] == query_date ? :active : nil		
		if hash[:article?]
			content_tag :div, class: "number-cell #{hash[:today]} #{active}" do
		    link_to hash[:day], user_path(@user, query_date: query_date)
	    end
		else
			content_tag :div, class: "number-cell #{hash[:today]}" do 
				content_tag :div, hash[:day]
			end	
		end  
	end

	def event_cell(hash)
		color = hash[:event].last.color if !hash[:event].empty?
		content_tag :div, class: "event-cell  #{color}" do
			content_tag :div, class: "hide-events" do
				if !hash[:event].empty?
 	 		    hash[:event].each do |i|
 	 			  concat render 'calendar/event_box', i: i
 	 		    end	
		    end 
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

	def stretch(event)
		if event.stretch > 1
			end_date = event.date + event.stretch.day - 1
			"#{event.date.strftime('%B %d')} - #{end_date.strftime('%B %d')}" 
		else
			event.date.strftime('%B %d')
		end	
	end
end
