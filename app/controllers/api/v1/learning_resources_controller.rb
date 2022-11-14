class Api::V1::LearningResourcesController < ApplicationController
  def index
    country = params[:country].downcase
    resources = LearningResourcesFacade.get_resources(country)
    render json: LearningResourceSerializer.new(resources)
  end
end
