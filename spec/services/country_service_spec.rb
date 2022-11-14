require 'rails_helper'

RSpec.describe 'CountryService' do
  it 'can get a random country', :vcr do
    result = CountryService.random_country

    expect(result).to be_a String
  end
end