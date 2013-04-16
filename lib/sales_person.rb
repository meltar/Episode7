class SalesPerson

  attr_reader :cities
  def initialize
    @cities = []
  end

  def schedule_city(city)
    @cities << city unless @cities.include?(city)
  end

  def find_city(city_name)
    found = cities.select {|city| city if city.name == city_name}
    found.first
  end

  def route(start)
    city = find_city(start)
    vals = CalculatesRoute.calculate(cities, city)
    results = {route: vals.fetch(:route), time: traveling_time(vals.fetch(:distance)) }
  end

  def traveling_time(distance)
    time = distance / 55
  end

end
