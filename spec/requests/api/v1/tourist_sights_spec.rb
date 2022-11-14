require 'rails_helper'

RSpec.describe 'tourist sights API' do
  describe 'happy path' do
    it 'will return all tourists sights within a 20,000 meter radius of the capital city' do
      get '/api/v1/tourist_sights?country=France'

      expect(response).to be_successful
    end
  end
end