class Api::V1::FavoritesController < ApplicationController
  before_action :find_user, only: %i[index create]

  def index
    favorites = Favorite.where(user_id: @user.id)
    render json: FavoriteSerializer.new(favorites)
  end

  def create
    favorite = Favorite.create(favorite_params)
    favorite.user_id = @user.id
    favorite.save
    render json: { success: 'Favorite added successfully' }, status: 201
  end

  def destroy
    Favorite.destroy(params[:id])
    render json: { success: 'Favorite has been removed' }, status: 202
  end

  private

  def favorite_params
    params.permit(:api_key, :country, :recipe_link, :recipe_title, :created_at)
  end

  def find_user
    @user = User.find_by(api_key: params[:api_key])
    return unless @user.nil?

    render json: { error: { details: 'That api_key does not exist' } }, status: 404
  end
end
