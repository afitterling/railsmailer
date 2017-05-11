class UserMailer < ApplicationMailer
  default from: ENV['DEFAULT_SENDER']

  def welcome_email(email)
    mail(to: email, subject: "Welcome!")
  end
end
