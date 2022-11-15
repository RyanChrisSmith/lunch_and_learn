class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UserSerializer.format_user(user)
    else
      render json: { error: { details: 'must use valid username or password' } }
    end
  end
end
