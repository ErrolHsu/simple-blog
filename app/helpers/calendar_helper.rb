module CalendarHelper

	def calendar
		days = Time.days_in_month(@date.month, @date.year)
		active_day = params[:day] ? params[:day].to_i : nil
		c = Calendar.new(days) { |i| i + 1 }
		c.to_complete_calendar(@date, @special_days, active_day)
	end

	def each_day(hash)
		if hash[:mark] 
			content_tag :div, class: "been-mark op" do
				content_tag :div, class: "mark-#{hash[:mark]}", id: "mark-#{hash[:today?]}" do
			    link_to hash[:day], 
			    user_path(@user, year: @date.year, month: @date.month, day: hash[:day])
	  	  end 
		  end  	 
		else
			content_tag :div , class: "normal-days" do
				content_tag :div, hash[:day], id: "mark-#{hash[:today?]}"
			end	
		end	
	end

	def previous_month
		date = @date.prev_month
		previous_month = date.strftime("%b")
		link_to "《 #{previous_month}", user_path(@user, month: date.month, year: date.year), id: "previous_month"
	end

	def next_month
		if @date.beginning_of_month != Time.zone.now.beginning_of_month
		  date = @date.next_month
		  next_month = (@date.beginning_of_month + 1.month).strftime("%b")
			link_to "#{next_month} 》", user_path(@user, month: date.month, year: date.year), id: "next_month"
		end	
	end

end
