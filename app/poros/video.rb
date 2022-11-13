class Video
  attr_accessor :title,
                :youtube_video_id

  def initialize(video_data)
    if video_data == []
      return []
    else
      @title = video_data[:snippet][:title]
      @youtube_video_id = video_data[:id][:videoId]
    end
  end
end