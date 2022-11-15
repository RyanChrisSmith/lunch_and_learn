require 'rails_helper'

RSpec.describe 'Recipes API' do
  it 'can return an API call with only specific country related info', :vcr do
    response = RecipeService.find_recipes('thailand')

    expect(response).to be_a Hash

    response[:hits].each do |recipe|
      expect(recipe[:recipe]).to have_key(:label)
      expect(recipe[:recipe][:label]).to be_a String

      expect(recipe[:recipe]).to have_key(:url)
      expect(recipe[:recipe][:url]).to be_a String

      expect(recipe[:recipe]).to have_key(:image)
      expect(recipe[:recipe][:image]).to be_a String
    end
  end
end
