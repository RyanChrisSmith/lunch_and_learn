require 'rails_helper'

RSpec.describe TouristSightsService do 
  describe 'happy path' do
    it 'can get all the tourist sights within a 20,000 meter radius' do
      lat_long = CountryService.lat_long('France')
      sights = TouristSightService.get_sights(lat_long[0],lat_long[1])

      require 'pry' ; binding.pry
    end
  end
end