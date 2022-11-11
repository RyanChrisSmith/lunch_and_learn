class Api::V1::RecipesController < ApplicationController
  def index
    render json: RecipeSerializer.new(Recipe.where(country: params[:country]))
  end
end
