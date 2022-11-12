class Api::V1::RecipesController < ApplicationController
  def index
    if params[:country] == ""
      @recipes = RecipeFacade.random
    else
      country = params[:country].downcase
      @recipes = RecipeFacade.search(country)
    end
    render json: RecipeSerializer.new(@recipes)
  end
end
