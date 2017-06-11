class MailersController < ApplicationController
  before_action :require_user_access_token

  def create
    @mailer = Mailer.new(mailer_params)

    if @mailer.save
      render json: @mailer
    else
      render json: {errors: @mailer.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def mailer_params
    params.permit(:address, :port, :domain, :user_name, :password,
                  :authentication, :enable_starttls_auto, :openssl_verify_mode,
                  :uid)
  end
end
