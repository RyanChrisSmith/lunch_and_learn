class CountryService
  def self.random_country
    all = Rails.cache.fetch(response = conn.get('/v3.1/all?fields=name'), expires: 30.days) do
      JSON.parse(response.body, symbolize_names: true)
    end
    all.map { |country| country[:name][:common] }.sample
  end

  def self.lat_long(country)
    response = conn.get("/v3.1/name/#{country}")
    country_info = JSON.parse(response.body, symbolize_names: true)
    lat_long = country_info[0][:latlng].reverse
  end

  def self.conn
    Faraday.new('https://restcountries.com')
  end
end
