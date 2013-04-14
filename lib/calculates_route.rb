class CalculatesRoute

  def self.calculate(points, start_point)

    remaining_points = points
    route = []
    if start_point.nil?
      route << remaining_points.slice!(0)
    else
      route << remaining_points.slice!(remaining_points.index(start_point))
    end
    until remaining_points == [] do 
      next_point = shortest_distance(route.last, remaining_points)
      route << remaining_points.slice!(remaining_points.index(next_point))
    end
    route
  end

  def self.shortest_distance(from, possible)
    distances = possible.map do |point|
      {point: point, distance: Map.distance_between(from, point)}
    end
    distances.sort{|a,b| a.fetch(:distance) <=> b.fetch(:distance)}.first.fetch(:point)
  end
end

