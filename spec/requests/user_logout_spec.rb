require 'rails_helper'

RSpec.describe "UserLogout", type: :request do
  before(:each) do
    @access_token = create(:access_token)
    @user = @access_token.user
  end

  describe "DELETE /user/sign_out" do
    it "should return no_content if access token is valid" do
      expect do
        delete "/users/sign_out.json", nil, "X-Access-Token" => @access_token.token
      end.to change { AccessToken.count }.by(-1)

      expect(response).to have_http_status(:no_content)

      destroyed_token = AccessToken.find_by(token: @access_token.token)
      expect(destroyed_token).to be_nil
    end

    it "should return unauthorized if access token is not present" do
      expect do
        delete "/users/sign_out.json"
      end.not_to change { AccessToken.count }

      expect(response).to have_http_status(:unauthorized)
    end

    it "should return unauthorized if access token is invalid" do
      invalid_token = "foobar123"
      access_token = AccessToken.find_by(token: invalid_token)
      expect(access_token).to be_nil

      expect do
        delete "/users/sign_out.json", nil, "X-Access-Token" => "foobar123"
      end.not_to change { AccessToken.count }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
