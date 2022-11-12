require 'rails_helper'

RSpec.describe 'User API' do
  it 'upon registration, can recieve a POST request and return structured response' do
    user_params =
        {
          "name": 'Johnny Fantastic',
          "email": 'johnny@fantastic.com',
          "password": 'password',
          "password_confirmation": 'password'
        }

    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    expect(response).to be_successful

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
end