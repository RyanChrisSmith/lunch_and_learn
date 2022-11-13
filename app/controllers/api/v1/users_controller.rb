class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: user.errors.messages
    end
  end


  private
  def user_params
    params.permit(:name, :email, :password, :password_confrimation)
  end

end