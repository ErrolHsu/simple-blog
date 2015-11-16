module CalendarHelper

	Array.class_eval do
		def be_group_by(n)
			array = []
			each_with_index do |item, index|
				if index % n == 0
				 	array << []
				end
				array.last << item
			end
			array.last << {day: nil, mark: false} until array.last.size == n
			array
		end
	end	

	def build_calendar_item(array)
		first_day = @date.beginning_of_month
		first_day.wday.times do 
			array.unshift({day: nil, mark: false})	
		end
		array
	end

	def calendar(array, n)
		build_calendar_item(array).be_group_by(n)
	end

	def each_day(hash)
		if hash[:mark] 
			content_tag :div, class: "mark-true" do
				if hash[:mark] == "today"
					content_tag :div, hash[:day], id: "mark-today"
				else	
				  content_tag :div, id: "mark-#{hash[:mark]}" do
				    link_to hash[:day], 
				    user_path(@user, year: @date.year, month: @date.month, day: hash[:day])
				  end  
			  end
			end	
		else
			content_tag(:div, hash[:day], class: "normal-days")	
		end	
	end

	def previous_month
		date = (@date.beginning_of_month - 1.month)
		previous_month = date.strftime("%b")
		link_to "《 #{previous_month}", user_path(@user, month: date.month, year: date.year), id: "previous_month"
	end

	def next_month
		if @date.beginning_of_month != Time.zone.now.beginning_of_month
		  date = (@date.beginning_of_month + 1.month)
		  next_month = (@date.beginning_of_month + 1.month).strftime("%b")
			link_to "#{next_month} 》", user_path(@user, month: date.month, year: date.year), id: "next_month"
		end	
	end

end
