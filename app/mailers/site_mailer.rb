class SiteMailer < ApplicationMailer
  def email(site_id, email, message, name, address, phone)
    @site = Site.find(site_id)
    @email, @message, @name, @address, @phone = email, message, name, address, phone
    mail(to: @site.recipient, from: @email, subject: "Email from #{@site.name}")
  end
end
