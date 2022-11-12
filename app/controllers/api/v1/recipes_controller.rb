class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country].downcase
    @recipes = RecipeFacade.search(country)

    render json: RecipeSerializer.new(@recipes)
  end
end
