class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country].downcase
    render json: RecipeSerializer.new(Recipe.where(country: country))
  end
end
