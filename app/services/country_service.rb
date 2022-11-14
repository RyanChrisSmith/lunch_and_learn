class CountryService

  def self.random_country
    response = conn.get("/v3.1/all?fields=name,alpha2Code,latlng")
    all = JSON.parse(response.body, symbolize_names:true )
    all.map{|country| country[:name][:official]}.sample
  end

  private
  def self.conn
    Faraday.new("https://restcountries.com")
  end
end