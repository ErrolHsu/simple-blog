task :op => :environment do
	TodoEvent.all.each do |i|
		i.color = "blue"
		i.save
		puts "set #{i.event}" 
	end	
end

task :set_series => :environment do
	Article.all.each do |i|
		i.series = "normal"
		i.save
		puts "#{i.title} series = normal"
	end	
end