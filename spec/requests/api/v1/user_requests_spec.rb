require 'rails_helper'

RSpec.describe 'User API' do
  it 'upon registration, can recieve a POST request and return structured response', :vcr do
    user_params =
        {
          "name": 'Ronny Fantastic',
          "email": 'ronny@fantastic.com',
          "password": 'password',
          "password_confirmation": 'password'
        }

    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    expect(response).to be_successful
    expect(request.query_parameters).to eq({})
    expect(request.request_parameters).to include(user_params)

    created_user = JSON.parse(response.body, symbolize_names: true )

    expect(created_user).to have_key(:data)

    expect(created_user[:data]).to have_key(:id)
    expect(created_user[:data][:id]).to be_a String

    expect(created_user[:data]).to have_key(:type)
    expect(created_user[:data][:type]).to be_a String
    expect(created_user[:data][:type]).to eq('user')

    expect(created_user[:data]).to have_key(:attributes)
    expect(created_user[:data][:attributes]).to have_key(:name)
    expect(created_user[:data][:attributes][:name]).to be_a String

    expect(created_user[:data][:attributes]).to have_key(:email)
    expect(created_user[:data][:attributes][:email]).to be_a String

    expect(created_user[:data][:attributes]).to have_key(:api_key)
    expect(created_user[:data][:attributes][:api_key]).to be_a String
  end

  it 'upon registration, can recieve a POST request with missing password an error response related to the password missing', :vcr do
    user_params =
        {
          "name": 'Ronny Fantastic',
          "email": 'ronny@fantastic.com'
        }

    headers = {"CONTENT_TYPE" => "application/json"}
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    error = JSON.parse(response.body, symbolize_names: true )

    expect(error).to have_key(:password)
    expect(error[:password]).to eq(["can't be blank"])
  end

  it 'upon registration, can recieve a POST request without an email an error related to needing an email', :vcr do
    user_params =
    {
      "name": 'Ronny Fantastic',
      "password": 'password',
      "password_confirmation": 'password'
    }

    headers = {"CONTENT_TYPE" => "application/json"}
    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    error = JSON.parse(response.body, symbolize_names: true )

    expect(error).to have_key(:email)
    expect(error[:email]).to eq(["can't be blank"])
  end

  it 'upon registration, can recieve a POST request with an already used email and return an error of duplicate email', :vcr do
    user = User.create!(name: 'Ronny Fantastic', email: 'ronny@fantastic.com', password: 'password', password_confirmation: 'password')
    user_params =
        {
          "name": 'I am a thief',
          "email": 'ronny@fantastic.com',
          "password": 'password',
          "password_confirmation": 'password'
        }

    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    error = JSON.parse(response.body, symbolize_names: true )

    expect(error).to have_key(:email)
    expect(error[:email]).to eq(["has already been taken"])
  end
end