class Calendar < Array

	private_class_method :new
	
	def initialize(date, special_days, user)
		days = Time.days_in_month(date.month, date.year)
		@user = user
		@datetime = date
		@article_days = special_days[0][:article_days]
		@event_days = special_days[0][:event_days]
		@active_day = special_days[1]
		array = Array.new(days) { |i| i + 1 }
		self.concat(array)
	end


	class << self
	  def to_normal_calendar(date, special_days, user)
	  	c = new(date, special_days, user)
	  	c.mark_calendar.todo_event.normalize
	  end
	end

	def todo_event
		if @user.calendar_todo_events == "1"
		  @event_days.each do |i|
		  	i[:stretch].times do |x|
		    	self[i[:date_num] - 1 + x][:event] = "event"
		  	end		 
		  end
		end  
		self
	end

	def mark_calendar
		now = Time.zone.now
		self.map! { |i| {day: i} }
		@article_days.each { |i| self[i - 1][:mark] = "mark"}
    self[@active_day - 1][:mark] = "active" if @active_day
    if @datetime.beginning_of_month == now.beginning_of_month && @active_day == Time.zone.now.day
      self[now.day - 1][:today?] = "today-active"
    elsif @datetime.beginning_of_month == now.beginning_of_month 
      self[now.day - 1][:today?] = "today"
    end  
    self
	end


	def normalize
		new_calendar = []
		first_day = @datetime.beginning_of_month
		first_day.wday.times { unshift({day: nil, mark: false}) } 
		each_slice(7) { |group| new_calendar << group }		
		new_calendar.last << {day: nil, mark: false} until new_calendar.last.size == 7
		new_calendar
	end


end