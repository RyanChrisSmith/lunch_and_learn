require 'rails_helper'

RSpec.describe 'Learning Resource API requests' do
  describe 'happy path' do
    it 'returns videos and images related to country search', :vcr do
      get '/api/v1/learning_resources?country=laos'
      resources = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(resources).to be_a Hash
      expect(resources).to have_key(:data)

      expect(resources[:data]).to have_key(:id)
      expect(resources[:data][:id]).to eq('null')

      expect(resources[:data]).to have_key(:type)
      expect(resources[:data][:type]).to eq('learning_resource')

      expect(resources[:data]).to have_key(:attributes)
      expect(resources[:data][:attributes]).to have_key(:country)
      expect(resources[:data][:attributes][:country]).to eq('laos')

      expect(resources[:data][:attributes]).to have_key(:video)
      expect(resources[:data][:attributes][:video][0]).to have_key(:title)
      expect(resources[:data][:attributes][:video][0][:title]).to be_a String
      expect(resources[:data][:attributes][:video][0]).to have_key(:youtube_video_id)
      expect(resources[:data][:attributes][:video][0][:youtube_video_id]).to be_a String
      expect(resources[:data][:attributes][:images]).to be_a Array

      resources[:data][:attributes][:images].each do |image|
        expect(image).to have_key(:alt_tag)
        expect(image[:alt_tag]).to be_a String
        expect(image).to have_key(:url)
        expect(image[:url]).to be_a String
      end
    end

    it 'returns empty values when nothing matches the search query', :vcr do
      get '/api/v1/learning_resources?country=sdlkfjalskjdflkasjdlfkj'
      resources = JSON.parse(response.body, symbolize_names: true)

      expect(resources[:data][:attributes][:country]).to eq('sdlkfjalskjdflkasjdlfkj')

      expect(resources[:data][:attributes][:video]).to eq([])
      expect(resources[:data][:attributes][:images]).to eq([])
    end
  end

  describe 'sad/edge path' do
    it 'will still search for the country when capitalized errently', :vcr do
      get '/api/v1/learning_resources?country=LAos'
      resources = JSON.parse(response.body, symbolize_names: true)

      expect(resources[:data][:attributes][:country]).to eq('laos')
      expect(resources[:data][:attributes][:country]).to_not eq('LAos')
    end
  end
end
