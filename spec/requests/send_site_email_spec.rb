require 'rails_helper'

RSpec.describe "SendSiteEmail", type: :request do
  it "should send the email" do
    ActionMailer::Base.deliveries.clear

    site = create(:site)
    expect do
      post deliver_site_email_path(site.uid), email: "user@example.com",
                                              message: "message",
                                              name: "name",
                                              address: "address",
                                              phone: "phone"
      expect(response).to have_http_status(:ok)
    end.to change { ActionMailer::Base.deliveries.count }.by(1)

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to include site.recipient
    expect(mail.from).to include "user@example.com"
  end
end
