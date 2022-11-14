require 'rails_helper'

RSpec.describe 'Sessions request' do
  before :each do
    User.create!(name: 'Ronny Fantastic',email: 'ronny@fantastic.com',password: 'password', password_confirmation: 'password')
  end

  it 'can sign a registed user in', :vcr do
    user_params =
    {
      "email": 'ronny@fantastic.com',
      "password": 'password',
    }
    post '/api/v1/sessions', params: user_params

    signed_in = JSON.parse(response.body, symbolize_names: true)

    expect(signed_in).to have_key(:data)

    expect(signed_in[:data]).to have_key(:id)
    expect(signed_in[:data][:id]).to be_a String

    expect(signed_in[:data]).to have_key(:type)
    expect(signed_in[:data][:type]).to be_a String
    expect(signed_in[:data][:type]).to eq('user')

    expect(signed_in[:data]).to have_key(:attributes)
    expect(signed_in[:data][:attributes]).to have_key(:name)
    expect(signed_in[:data][:attributes][:name]).to be_a String

    expect(signed_in[:data][:attributes]).to have_key(:email)
    expect(signed_in[:data][:attributes][:email]).to be_a String

    expect(signed_in[:data][:attributes]).to have_key(:api_key)
    expect(signed_in[:data][:attributes][:api_key]).to be_a String
  end

  it 'cannot sign in a registed user with the wrong password', :vcr do
    user_params =
    {
      "email": 'ronny@fantastic.com',
      "password": 'wrongpassword',
    }
    post '/api/v1/sessions', params: user_params

    not_signed_in = JSON.parse(response.body, symbolize_names: true)

    expect(not_signed_in).to be_a Hash
    expect(not_signed_in).to have_key(:error)
    expect(not_signed_in[:error]).to have_key(:details)
    expect(not_signed_in[:error][:details]).to eq("must use valid username or password")
  end
end