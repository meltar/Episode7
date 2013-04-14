require 'geocoder'

Geocoder.configure(
  lookup: :bing,
  api_key: 'AkTjVpt-Si67rkjRTerrBqnmMIJSwWAEXSsoMJQMHa3ZO1rbHbECo1crQ_iuGTg-'
)

class Map

  def self.search(terms)
    Array(Geocoder.search(terms)).first
  end

  def self.distance_between(first, second)
    Geocoder::Calculations.distance_between(first, second)
  end
end
