class Api::V1::TouristSightsController < ApplicationController
  def index
    require 'pry' ; binding.pry
    render json: TouristSightSerializer.new(TouristSightsFacade.sights)
  end
end
