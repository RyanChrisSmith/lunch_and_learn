require 'rails_helper'

RSpec.describe 'Favorites API' do
  before :each do
    @karl = User.create!(name: 'Jim', email: 'jims@home.com', password: 'password', password_confirmation: 'password')
    @user = User.create!(name: 'How many', email: 'testsareneeded@home.com', password: 'password', password_confirmation: 'password')
    Favorite.create!(api_key: @user.api_key, country: 'thailand', recipe_link: "https://www.tastingtable.com/.....", recipe_title: 'Tom Kha Gai (Chicken in Coconut Soup)', user_id: @user.id)
    Favorite.create!(api_key: @user.api_key, country: 'mexico', recipe_link: "https://www.tastingtable.com/.....", recipe_title: 'Tacos', user_id: @user.id)
    Favorite.create!(api_key: @user.api_key, country: 'canada', recipe_link: "https://www.tastingtable.com/.....", recipe_title: 'Poutine fries', user_id: @user.id)
  end

  describe 'Happy path' do
    it 'will create a favorite recipe with api key', :vcr do
      fav_params = {
        "api_key": @user.api_key,
        "country": "germany",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Bratwurst"
      }
      headers = {"CONTENT_TYPE" => 'application/json'}

      post '/api/v1/favorites', headers: headers, params: JSON.generate(fav_params)

      new_favorite = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 201
      expect(request.query_parameters).to eq({})
      expect(request.request_parameters).to include(fav_params)

      expect(new_favorite).to have_key(:success)
      expect(new_favorite[:success]).to eq("Favorite added successfully")
    end

    it 'can retrieve a list of favorites by the api key', :vcr do
      body = {
        api_key: @user.api_key
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      get '/api/v1/favorites', headers: headers, params: body

      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a Hash
      expect(results).to have_key(:data)

      results[:data].each do |result|
        expect(result).to have_key(:id)
        expect(result[:id]).to be_a String

        expect(result).to have_key(:type)
        expect(result[:type]).to eq('favorite')

        expect(result).to have_key(:attributes)
        expect(result[:attributes]).to have_key(:recipe_title)
        expect(result[:attributes][:recipe_title]).to be_a String

        expect(result[:attributes]).to have_key(:recipe_link)
        expect(result[:attributes][:recipe_link]).to be_a String

        expect(result[:attributes]).to have_key(:country)
        expect(result[:attributes][:country]).to be_a String

        expect(result[:attributes]).to have_key(:created_at)
        expect(result[:attributes][:created_at]).to be_a String
      end
    end

    it 'will return an empty array for users who dont have favorites', :vcr do
      body = {
        api_key: @karl.api_key
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      get '/api/v1/favorites', params: body
      expect(response).to be_successful

      favorites = JSON.parse(response.body, symbolize_names: true)

      expect(favorites).to have_key(:data)
      expect(favorites[:data]).to eq([])
    end
  end

  describe 'sad path' do
    it 'cannot create a favorite with the wrong API key', :vcr do
      fav_params = {
        "api_key": @user.api_key.chop,
        "country": "germany",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Bratwurst"
      }
      headers = {"CONTENT_TYPE" => 'application/json'}

      post '/api/v1/favorites', headers: headers, params: JSON.generate(fav_params)

      wrong_info = JSON.parse(response.body, symbolize_names: true)
      last_favorite = Favorite.last

      expect(wrong_info).to have_key(:error)
      expect(last_favorite.country).to_not eq(fav_params[:country])
    end

    it 'cannot create a favorite without an API key', :vcr do
      fav_params = {
        "country": "germany",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Bratwurst"
      }
      headers = {"CONTENT_TYPE" => 'application/json'}

      post '/api/v1/favorites', headers: headers, params: JSON.generate(fav_params)

      missing_info = JSON.parse(response.body, symbolize_names: true)
      last_favorite = Favorite.last

      expect(missing_info).to have_key(:error)
      expect(last_favorite.country).to_not eq(fav_params[:country])
    end
  end

  end
