Dir["./lib/*.rb"].each {|file| require file }


phil = SalesPerson.new
phil.schedule_city(Place.build("Target, Marietta, GA"))
phil.schedule_city(Place.build("IKEA, Atlanta, GA"))
phil.schedule_city(Place.build("Petco, Kennesaw, GA"))
phil.schedule_city(Place.build("Hobbytown USA, Kennesaw, GA"))
phil.schedule_city(Place.build("Publix Delk Rd, Marietta, GA"))

puts "All places:"
puts phil.cities
puts 
puts "Where should the person start?"
puts
start = gets.chomp
if (start.empty? == false)
	puts "The route:"
	puts phil.route(start)
end