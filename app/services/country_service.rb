class CountryService

  def self.random_country
    response = conn.get("/v2/all?fields=name")
    all = JSON.parse(response.body, symbolize_names:true )
    all.map{|country| country[:name]}.sample
  end

  private
  def self.conn
    Faraday.new("https://restcountries.com")
  end
end