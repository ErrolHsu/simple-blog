task :op => :environment do
	TodoEvent.all.each do |i|
		i.day = 1
		i.save
		puts "set #{i.event}" 
	end	
end

task :delete_event => :environment do
	TodoEvent.all.each do |i|
		i.delete
		puts "刪除#{i.event}"
	end	
end