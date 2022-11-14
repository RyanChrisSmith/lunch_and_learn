class CountryService

  def self.random_country
    response = conn.get("/v3.1/all?fields=name,alpha2Code,latlng")
    all = JSON.parse(response.body, symbolize_names:true )
    all.map{|country| country[:name][:common]}.sample
  end

  def self.lat_long(country)
    response = conn.get("/v3.1/name/#{country}")
    country_info = JSON.parse(response.body, symbolize_names: true)
    lat_long = country_info[0][:latlng].reverse
  end

  private
  def self.conn
    Faraday.new("https://restcountries.com")
  end
end