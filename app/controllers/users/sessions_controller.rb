class Users::SessionsController < ApplicationController
  before_action :require_access_token, only: :destroy

  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      access_token = user.access_tokens.create
      render json: {access_token: access_token}
    else
      render json: {errors: ["Email and/or password are invalid"]}, status: :forbidden
    end
  end

  def destroy
    access_token.destroy
    access_token = nil
    render nothing: true, status: :no_content
  end
end
