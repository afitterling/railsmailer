class MailersController < ApplicationController
  before_action :require_user_access_token
  before_action :assign_mailer, only: :deliver

  def create
    @mailer = Mailer.new(mailer_params)

    if @mailer.save
      render json: @mailer
    else
      render json: {errors: @mailer.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def deliver
    SharedMailer.email(@mailer.uid, email_params[:to], email_params[:from],
                       email_params[:subject], email_params[:body]).deliver_later
    render plain: "ok"
  end

  private

  def mailer_params
    params.permit(:address, :port, :domain, :user_name, :password,
                  :authentication, :enable_starttls_auto, :openssl_verify_mode,
                  :uid)
  end

  def email_params
    params.permit(:to, :from, :subject, :body)
  end

  def assign_mailer
    @mailer = Mailer.find_by(uid: params[:uid])
    render json: {errors: ["Mailer not found"]}, status: :not_found unless @mailer
  end
end
