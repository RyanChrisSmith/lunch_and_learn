require 'rails_helper'

RSpec.describe 'Learning Resource API requests' do
  it 'returns videos and images related to country search' do
    get '/api/v1/learning_resources?country=laos'
  end
end