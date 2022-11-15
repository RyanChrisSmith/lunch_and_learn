class Api::V1::TouristSightsController < ApplicationController
  def index
    sights = if params[:country] == ''
               TouristSightsFacade.random
             else
               TouristSightsFacade.sights(params[:country])
             end
    render json: TouristSightSerializer.new(sights)
  end
end
