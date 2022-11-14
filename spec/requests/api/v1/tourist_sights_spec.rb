require 'rails_helper'

RSpec.describe 'tourist sights API' do
  describe 'happy path' do
    it 'will return all tourists sights within a 20,000 meter radius of the capital city' do
      get '/api/v1/tourist_sights?country=France'

      expect(response).to be_successful
      sights = JSON.parse(response.body, symbolize_names: true)
      expect(sights).to be_a Hash
      expect(sights).to have_key(:data)
      sights[:data].each do |sight|
        require 'pry' ; binding.pry
        expect(sight).to have_key(:id)
        expect(sight[:id]).to be_a String
        expect(sight[:id]).to be_a String

      end
    end
  end
end
