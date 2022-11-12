class ImagesService
  def self.get_images(query)
    response = conn.get("/search/photos") do |req|
      req.params['query'] = "#{query}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end


  private
  def self.conn
    Faraday.new(url: "https://api.unsplash.com") do |req|
      req.params['client_id'] = ENV['access_key']
    end
  end
end
