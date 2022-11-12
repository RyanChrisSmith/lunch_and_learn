require 'rails_helper'

RSpec.describe 'Video API' do
  it 'returns info needeed', :vcr do
    video = VideoService.get_video('laos')

    expect(video).to be_a Hash
require 'pry' ; binding.pry
    expect(video[:items][0][:id]).to have_key(:videoId)
    expect(video[:items][0][:id][:videoId]).to be_a String
    expect(video[:items][0][:snippet]).to have_key(:title)
    expect(video[:items][0][:snippet][:title]).to be_a String
  end
end