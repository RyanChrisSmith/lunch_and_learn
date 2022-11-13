class LearningResourcesFacade
  def self.get_resources(country)
    results = VideoService.get_video(country)
    video = results[:items].map do |video_data|
      Video.new(video_data)
    end

    response = ImagesService.get_images(country)
    images = response[:results].map do |image_data|
      Image.new(image_data)
    end
    LearningResource.new(country, video, images)
  end
end