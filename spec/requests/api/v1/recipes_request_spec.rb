require 'rails_helper'

RSpec.describe 'Recipes API' do
  it 'sends a list of recipes from a specified country' do
    recipes = create_list(:recipe, 5, country: 'thailand')
    recipes2 = create_list(:recipe, 3)

    get '/api/v1/recipes?country=thailand'
    thai_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    require 'pry' ; binding.pry
  end
end