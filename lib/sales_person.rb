class SalesPerson

  attr_reader :cities
  def initialize
    @cities = []
  end

  def schedule_city(city)
    @cities << city unless @cities.include?(city)
  end

  def find_city(city_name)
    found = @cities.select {|city| city if city.name == city_name}
    found.first
  end

  def route(start)
    CalculatesRoute.calculate(cities, find_city(start))
  end
end
