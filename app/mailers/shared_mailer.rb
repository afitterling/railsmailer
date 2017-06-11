class SharedMailer < ApplicationMailer
  def email(mailer_uid, to, from, subject, body)
    mailer = Mailer.find_by(uid: mailer_uid)

    mail(to: to, from: from, subject: subject, body: "Body",
         delivery_method_options: mailer.action_mailer_config)
  end
end
