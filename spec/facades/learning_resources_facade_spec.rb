require 'rails_helper'

RSpec.describe LearningResourcesFacade do
  it '#.get_resources' do
    resources = LearningResourcesFacade.get_resources('laos')

    expect(resources).to be_a LearningResource
  end
end