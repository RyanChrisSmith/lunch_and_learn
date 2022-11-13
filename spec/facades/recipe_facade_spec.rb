require 'rails_helper'

RSpec.describe RecipeFacade do
  it '#.search', :vcr do
    specific_country = RecipeFacade.search('thailand')

    expect(specific_country).to be_a Array
    expect(specific_country).to all(be_a Recipe)
  end

  it '#.random' do
    random = RecipeFacade.random

    expect(random).to be_a Array
    expect(random).to all(be_a Recipe)
  end
end