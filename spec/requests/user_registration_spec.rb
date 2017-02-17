require 'rails_helper'

RSpec.describe "UserRegistration", type: :request do
  describe "POST /users" do
    it "should return 200 if valid params are given" do
      expect do
        post "/users.json", email: "foo@example.com", password: "foobar123"
        expect(response).to have_http_status(200)

        expect(json_body).to have_key("user")
        expect(json_body).to have_key("access_token")
      end.to change { User.count }.by(1)
    end

    it "should return 422 if email is empty" do
      expect do
        post "/users.json", password: "foobar123"
        expect(response).to have_http_status(422)

        expect(json_body).to have_key("errors")
        expect(json_body["errors"]).to include "Email can't be blank"
      end.not_to change { User.count }
    end

    it "should return 422 if password is empty" do
      expect do
        post "/users.json", email: "foo@example.com"
        expect(response).to have_http_status(422)

        expect(json_body).to have_key("errors")
        expect(json_body["errors"]).to include "Password can't be blank"
      end.not_to change { User.count }
    end

    it "should return 422 if both email and password are empty" do
      expect do
        post "/users.json"
        expect(response).to have_http_status(422)

        expect(json_body).to have_key("errors")
        expect(json_body["errors"]).to include "Email can't be blank"
        expect(json_body["errors"]).to include "Password can't be blank"
      end.not_to change { User.count }
    end
  end
end
