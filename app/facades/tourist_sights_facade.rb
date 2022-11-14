class TouristSightsFacade
  def self.sights(country)
    lat_long = CountryService.lat_long(country)
    results = TouristSightsService.get_sights(lat_long[0], lat_long[1])
    results[:features].map do |data|
      TouristSight.new(data)
    end
  end

  def self.random
    country = CountryService.random_country
    sights(country)
  end
end