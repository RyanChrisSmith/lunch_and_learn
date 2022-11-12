class Api::V1::FavoritesController < ApplicationController

  def create
    if user = User.find_by(api_key: params[:api_key])
      favorite = Favorite.create(favorite_params)
      favorite.user_id = user.id
      favorite.save
      render json: {success: 'Favorite added successfully'}, status: 201
    else
      render status: 400
    end
  end

  private

  def favorite_params
    params.permit(:api_key, :country, :recipe_link, :recipe_title)
  end
end
