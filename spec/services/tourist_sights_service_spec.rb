require 'rails_helper'

RSpec.describe TouristSightsService do
  describe 'happy path' do
    it 'can get all the tourist sights within a 20,000 meter radius', :vcr do
      lat_long = CountryService.lat_long('France')
      sights = TouristSightsService.get_sights(lat_long[0],lat_long[1])

      expect(sights).to be_a Hash
      expect(sights).to have_key(:features)
      sights[:features].each do |sight|
        expect(sight[:properties]).to have_key(:name)
        expect(sight[:properties][:name]).to be_a String
        expect(sight[:properties]).to have_key(:formatted)
        expect(sight[:properties][:formatted]).to be_a String
        expect(sight[:properties]).to have_key(:place_id)
        expect(sight[:properties][:place_id]).to be_a String
      end
    end
  end
end