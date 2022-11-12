require 'rails_helper'

RSpec.describe 'Favorites API' do
  it 'will create a favorite recipe with api key' do
    fav_params = {
      "api_key": "b347e854e17cfd30c23c75b1a54d6ed2428073cd9caf94b6",
      "country": "thailand",
      "recipe_link": "https://www.tastingtable.com/.....",
      "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }
    headers = {"CONTENT_TYPE" => 'application/json'}

    post '/api/v1/favorites', headers: headers, params: JSON.generate(fav_params)

    new_favorite = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 201
    expect(new_favorite).to have_key(:success)
    expect(new_favorite[:success]).to eq("Favorite added successfully")
  end
end
