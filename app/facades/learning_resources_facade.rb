class LearningResourcesFacade
  def self.get_resources(country)
    video_data = VideoService.get_video(country)
    video = Video.new(video_data)

    response = ImagesService.get_images(country)
    images = response[:results].map do |image_data|
      Image.new(image_data)
    end

    LearningResource.new(country, video, images)
  end
end