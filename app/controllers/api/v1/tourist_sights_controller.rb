class Api::V1::TouristSightsController < ApplicationController
  def index
    if params[:country] == ''
      sights = TouristSightsFacade.random
    else
      sights = TouristSightsFacade.sights(params[:country])
    end
    render json: TouristSightSerializer.new(sights)
  end
end
