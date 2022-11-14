class TouristSightsService

  def self.get_sights(lat, long)
    response = conn.get("/v2/places?") do |req|
      req.params['categories'] = 'tourism.sights'
      req.params['filter'] = "circle:#{lat},#{long},20000"
      req.params['apiKey'] = ENV['places_key']
    end
    JSON.parse(response.body, symbolize_names: true)
  end


  private 

  def self.conn 
    Faraday.new("https://api.geoapify.com")
  end
end