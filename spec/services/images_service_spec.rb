require 'rails_helper'

RSpec.describe 'ImagesService' do
  it 'returns info on the specific query', :vcr do
    images = ImagesService.get_images('laos')
    expect(images).to be_a Hash
    expect(images[:results]).to be_a Array
    images[:results].each do |image|
      expect(image).to have_key(:alt_description)
      expect(image[:alt_description]).to be_a String

      expect(image).to have_key(:urls)
      expect(image[:urls]).to have_key(:raw)
      expect(image[:urls][:raw]).to be_a String
    end
  end
end
