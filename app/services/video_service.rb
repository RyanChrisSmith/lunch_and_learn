class VideoService
  def self.get_video(country)
    response = conn.get('/youtube/v3/search?') do |req|
      req.params['q'] = "#{country}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://youtube.googleapis.com') do |f|
      f.params['part'] = 'snippet'
      f.params['type'] = 'video'
      f.params['key'] = ENV['google_key']
      f.params['maxResults'] = '1'
    end
  end
end
