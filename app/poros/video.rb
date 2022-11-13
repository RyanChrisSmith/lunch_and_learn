class Video
  attr_accessor :title,
                :youtube_video_id

  def initialize(video_data)
    if video_data[:items] == []
      return []
    else
      @title = video_data[:items][0][:snippet][:title]
      @youtube_video_id = video_data[:items][0][:id][:videoId]
    end
  end
end