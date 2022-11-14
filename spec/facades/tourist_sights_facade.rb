class TouristSightsFacade
  def self.sights(lat, long)

    results = TouristSightsService.get_sights(lat, long)
    sights = results[:features].map do |data|
      TouristSight.new(data)
    end
  end
end