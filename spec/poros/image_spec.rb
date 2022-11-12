require 'rails_helper'

RSpec.describe 'Image PORO' do
  it 'can select out the info needed from the API call' do
    image_data = {
        alt_description: 'Only on Sundays',
        urls:{
          raw: 'http://fakeimages.com'
        }
      }

    image = Image.new(image_data)

    expect(image.alt_tag).to eq(image_data[:alt_description])
    expect(image.url).to eq(image_data[:urls][:raw])
  end
end