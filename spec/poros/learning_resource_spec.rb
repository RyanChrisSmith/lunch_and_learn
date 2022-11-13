require 'rails_helper'

RSpec.describe 'LearningResource PORO' do
  it 'will combine video, images, and country', :vcr do
    country = 'laos'
    video_data = VideoService.get_video(country)
    video = video_data[:items].map do |data|
      Video.new(data)
    end


    response = ImagesService.get_images(country)
    images = response[:results].map do |image_data|
      Image.new(image_data)
    end

    final = LearningResource.new(country, video, images)

    expect(final.country).to eq(country)
    expect(final.video).to eq(video)
    expect(final.images).to eq(images)
    expect(final.instance_variables).to eq(%i[@country @video @images])
  end
end