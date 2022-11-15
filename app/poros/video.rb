class Video
  attr_accessor :title,
                :youtube_video_id

  def initialize(video_data)
    return [] if video_data == []

    @title = video_data[:snippet][:title]
    @youtube_video_id = video_data[:id][:videoId]
  end
end
