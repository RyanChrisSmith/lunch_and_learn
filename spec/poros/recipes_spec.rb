require 'rails_helper'

RSpec.describe 'Recipes PORO' do
  it 'can get the info needed to make a PORO', :vcr do
    country = 'thailand'
    recipe = {
      recipe: {
        label: "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
        url: 'https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html',
        image: 'https://fakeimage'
      }
    }

    final = Recipe.new(recipe, country)

    expect(final.title).to eq(recipe[:recipe][:label])
    expect(final.url).to eq(recipe[:recipe][:url])
    expect(final.image).to eq(recipe[:recipe][:image])
    expect(final.country).to eq(country)
    expect(final.instance_variables).to eq(%i[@title @url @image @country])
  end
end
