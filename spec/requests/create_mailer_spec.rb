require 'rails_helper'

RSpec.describe "CreateMailer", type: :request do
  before(:each) do
    @access_token = create(:access_token)
    @user = @access_token.user
  end

  describe "POST /mailers" do
    it "should return 200 if valid access token is provided" do
      expect(Mailer.find_by(uid: 'uid')).to be_nil
      expect do
        post mailers_path, {uid: 'uid'}, "X-Access-Token" => @access_token.token
        expect(response).to have_http_status(:ok)
      end.to change { Mailer.count }.by(1)
    end

    it "should return 401 if no access token is given" do
      expect do
        post mailers_path
        expect(response).to have_http_status(:unauthorized)
      end.not_to change { Mailer.count }
    end

    it "should return 401 if invalid user access token is given" do
      token = "fake_token"
      expect(AccessToken.find_by(token: token)).to be_nil
      expect(DeviceAccessToken.find_by(token: token)).to be_nil

      expect do
        post mailers_path, nil, "X-Access-Token" => token
        expect(response).to have_http_status(:unauthorized)
      end.not_to change { Mailer.count }
    end

    it "should return 401 if device access token is given" do
      device_access_token = create(:device_access_token)

      expect do
        post mailers_path, nil, "X-Access-Token" => device_access_token.token
        expect(response).to have_http_status(:unauthorized)
      end.not_to change { Mailer.count }
    end
  end
end
