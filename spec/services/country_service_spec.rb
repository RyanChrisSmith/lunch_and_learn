require 'rails_helper'

RSpec.describe 'CountryService' do
  it 'can get a random country', :vcr do
    result = CountryService.random_country

    expect(result).to be_a String
  end

  it 'can get the country and lat long' do
    country = "France"
    result = CountryService.lat_long(country)

    expect(result).to be_a Array
    expect(result.count).to be 2
  end
end