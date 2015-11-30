class Calendar < Array

	private_class_method :new
	
	def initialize(date, special_days, settings)
		days = Time.days_in_month(date.month, date.year)
    array = Array.new(days) { |i| i + 1 }	
    @settings = settings
		@datetime = date
		@article_days = special_days[:article_days]
		@event_days = special_days[:event_days]
		self.concat(array)
	end


	class << self
	  def user_calendar(date, special_days, settings)
	  	c = new(date, special_days, settings)
	  	c.map! { |i| {day: i} }
	  	c.article.todo_event.today.normalize
	  end

	  def visitor_calendar(date, special_days, settings)
	  	c = new(date, special_days, settings)
	  	c.map! { |i| {day: i} }
	  	c.article.today.normalize
	  end
	end

	def todo_event
		if @settings[:event_days] == "1"
		  @event_days.each do |i|
		  	i[:stretch].times do |x|
		    	self[i[:date_num] - 1 + x][:event] = "event"
		    	self[i[:date_num] - 1 + x][:color] = i[:color]
		  	end		 
		  end
		end  
		self
	end

	def article
		if @settings[:article_days] == "1"
		  @article_days.each { |i| self[i - 1][:article_day] = "article_day"}
    end
    self  
	end

	def today
		if @settings[:today] == "1"
    	now = Time.zone.now
    	if @datetime.beginning_of_month == now.beginning_of_month 
        self[now.day - 1][:today] = "today"
      end 
    end 
    self
	end


	def normalize
		new_calendar = []
		first_day = @datetime.beginning_of_month
		first_day.wday.times { unshift({day: nil}) } 
		self.each_slice(7) { |group| new_calendar << group }		
		new_calendar.last << {day: nil} until new_calendar.last.size == 7
		new_calendar
	end

end
