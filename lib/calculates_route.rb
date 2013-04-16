class CalculatesRoute

  attr_reader :total_distance

  def self.calculate(points, start_point)
    @total_distance = 0
    remaining_points = points
    route = []
    index = remaining_points.index(start_point)
    if index.nil?
      route << remaining_points.slice!(0)
    else
      route << remaining_points.slice!(index)
    end
    until remaining_points == [] do 
      next_point = shortest_distance(route.last, remaining_points)
      route << remaining_points.slice!(remaining_points.index(next_point.fetch(:point)))
      @total_distance += next_point.fetch(:distance)
    end
    vals = {route: route, distance: @total_distance}
  end

  def self.shortest_distance(from, possible)
    distances = possible.map do |point|
      {point: point, distance: Map.distance_between(from, point)}
    end
    point = distances.sort{|a,b| a.fetch(:distance) <=> b.fetch(:distance)}.first 
  end
end
