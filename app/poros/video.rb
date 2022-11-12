class Video
  attr_reader :title, 
              :youtube_video_id 

  def initialize(video_data)
    @title = video_data[:items][0][:snippet][:title]
    @youtube_video_id = video_data[:items][0][:id][:videoId]
  end
end