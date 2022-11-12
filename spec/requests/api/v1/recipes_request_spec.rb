require 'rails_helper'

RSpec.describe 'Recipes API' do
  it 'sends a list of recipes from a specified country', :vcr do
    get '/api/v1/recipes?country=thailand'
    thai_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(thai_recipes).to be_a Hash

    thai_recipes[:data].each do |recipe|
      expect(recipe).to have_key(:id)
      expect(recipe[:id]).to eq('null')

      expect(recipe).to have_key(:type)
      expect(recipe[:type]).to eq('recipe')

      expect(recipe).to have_key(:attributes)
      expect(recipe[:attributes].count).to eq(4)

      expect(recipe[:attributes]).to have_key(:title)
      expect(recipe[:attributes][:title]).to be_a String

      expect(recipe[:attributes]).to have_key(:url)
      expect(recipe[:attributes][:url]).to be_a String

      expect(recipe[:attributes]).to have_key(:country)
      expect(recipe[:attributes][:country]).to be_a String
      expect(recipe[:attributes][:country]).to eq('thailand')

      expect(recipe[:attributes]).to have_key(:image)
      expect(recipe[:attributes][:image]).to be_a String
    end
  end

  it 'send back an empty array if the search parameter is an empty string', :vcr do
    get '/api/v1/recipes?country=""'
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data]).to eq([])
  end

  it 'send back an empty array if the search parameter does not exist or is mispelled', :vcr do
    get '/api/v1/recipes?country='
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result[:data]).to eq([])

    get '/api/v1/recipes?country=gerrrrmany'
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result[:data]).to eq([])
  end

  it 'will return the results if the search params are capitalized in any way', :vcr do
    get '/api/v1/recipes?country=THAILand'
    thai_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(thai_recipes).to be_a Hash

    thai_recipes[:data].each do |recipe|
      expect(recipe[:attributes][:country]).to eq('thailand')
    end
  end
end