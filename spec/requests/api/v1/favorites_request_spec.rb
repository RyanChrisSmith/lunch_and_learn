require 'rails_helper'

RSpec.describe 'Favorites API' do 
  it 'will create a favorite recipe with api key' do 
    fav_params = {
      "api_key": "0ad56748d44b6b493bd5ad1c711c9fdec8e3e2573d8c6c48",
      "country": "thailand",
      "recipe_link": "https://www.tastingtable.com/.....",
      "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }
    headers = {"CONTENT_TYPE" => 'application/json'}

    post '/api/v1/favorites', headers: headers, params: JSON.generate(fav_params)
require 'pry' ; binding.pry
  end
end
