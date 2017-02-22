class UserMailer < ApplicationMailer
  default from: 'bla@yihangho.com'

  def welcome_email(email)
    mail(to: email, subject: "Welcome!")
  end
end
