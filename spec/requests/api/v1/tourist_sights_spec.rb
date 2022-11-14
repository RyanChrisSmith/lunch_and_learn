require 'rails_helper'

RSpec.describe 'tourist sights API' do
  describe 'happy path' do
    it 'will return all tourists sights within a 20,000 meter radius of the capital city', :vcr do
      get '/api/v1/tourist_sights?country=France'

      expect(response).to be_successful

      sights = JSON.parse(response.body, symbolize_names: true)
      expect(sights).to be_a Hash
      expect(sights).to have_key(:data)

      sights[:data].each do |sight|
        expect(sight).to have_key(:id)
        expect(sight[:id]).to be_a String
        expect(sight[:id]).to eq('null')
        expect(sight).to have_key(:type)
        expect(sight[:type]).to eq('tourist_sight')
        expect(sight).to have_key(:attributes)
        expect(sight[:attributes]).to have_key(:name)
        expect(sight[:attributes][:name]).to be_a String
        expect(sight[:attributes]).to have_key(:address)
        expect(sight[:attributes][:address]).to be_a String
        expect(sight[:attributes]).to have_key(:place_id)
        expect(sight[:attributes][:place_id]).to be_a String
      end
    end
  end
end
