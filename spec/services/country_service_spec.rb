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
    expect(result[0]).to have_key(:name)
    expect(result[0][:name]).to have_key(:official)
    expect(result[0][:name][:common]).to be_a String
    expect(result[0][:name][:common]).to eq(country)
    expect(result[0]).to have_key(:latlng)
    expect(result[0][:latlng]).to be_a Array
    expect(result[0][:latlng].count).to eq 2
  end
end