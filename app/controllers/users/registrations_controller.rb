class Users::RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(user_params)

    if user.save
      UserMailer.welcome_email(user.email).deliver_later

      access_token = user.access_tokens.create
      render json: {
        access_token: access_token,
        user: user
      }
    else
      render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
