Dir["./lib/*.rb"].each {|file| require file }
require "benchmark"
require 'nokogiri'
require 'open-uri'

phil = SalesPerson.new
# these locations work with google, but not bing
#phil.schedule_city(Place.build("Target, Smyrna, GA"))
#phil.schedule_city(Place.build("IKEA, Atlanta, GA"))
#phil.schedule_city(Place.build("Petco, Kennesaw, GA"))
#phil.schedule_city(Place.build("Hobby Town USA, Kennesaw, GA"))
#phil.schedule_city(Place.build("Publix Delk Rd, Marietta, GA"))
phil.schedule_city(Place.build("Marietta, GA"))
phil.schedule_city(Place.build("Sandy Springs, GA"))
phil.schedule_city(Place.build("Roswell, GA"))
phil.schedule_city(Place.build("Buford, GA"))
phil.schedule_city(Place.build("Smyrna, GA"))

puts "All places:"
puts phil.cities
puts 
puts "Where should the person start?"
puts
start = gets.chomp
if (start.empty? == false)
	vals =  phil.route(start)
	puts "The route starting at #{start}:\n"
	puts vals.fetch(:route)
	travel = vals.fetch(:time)
	puts "Total traveling time in hours: #{vals.fetch(:time).round(2)}"

end

texas_cities = []
doc = Nokogiri::HTML(open('http://www.texas.gov/en/discover/Pages/topic.aspx?topicid=/government/localgov'))
doc.css(".TGOV_SCRD_Header a").map do |node|
  texas_cities << node.content
end

bench_vals = [2, 10, 50, 200]
bench_vals.each do |val|
	current = SalesPerson.new
	texas_cities.shuffle.take(val).each do |city|
		current.schedule_city(Place.build(city))
	end

	the_route = []
	puts "\nBenchmarking results for #{val} cities:"
	Benchmark.bm do |x|
		x.report do
			vals = current.route(nil)
		end
		puts "The route:"
		puts vals.fetch(:route)
		travel = vals.fetch(:time)
		puts "Total traveling time in hours: #{vals.fetch(:time).round(2)}"
	end
end