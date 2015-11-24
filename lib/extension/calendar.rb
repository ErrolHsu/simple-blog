class Calendar < Array


	def to_complete_calendar(date, special_days, active_day=nil)
		@date = date
		@special_days = special_days
		@active_day = active_day
		mark_calendar.match_weekday.be_group_by_every(7)
	end
	
	def mark_calendar
		now = Time.zone.now
		map! { |i| {day: i} }
		@special_days.each { |i| self[i - 1][:mark] = "mark"}
    self[@active_day - 1][:mark] = "active" if @active_day
    if @date.beginning_of_month == now.beginning_of_month && @active_day == Time.zone.now.day
      self[now.day - 1][:today?] = "today-active"
    elsif @date.beginning_of_month == now.beginning_of_month 
      self[now.day - 1][:today?] = "today"
    end  
    self
	end


	def be_group_by_every(n)
		new_calendar = Calendar.new
		each_slice(n) do |group|
			new_calendar << group
		end	
		new_calendar.last << {day: nil, mark: false} until new_calendar.last.size == n
		new_calendar
	end


	def match_weekday
		first_day = @date.beginning_of_month
		first_day.wday.times do 
			unshift({day: nil, mark: false})	
		end
		self
	end

end