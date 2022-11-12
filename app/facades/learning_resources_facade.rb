class LearningResourcesFacade 
  def self.get_resources(country)
    video_data = VideoService.get_video(country)
    video = Video.new(video_data)
  end
end