require 'rails_helper'

RSpec.describe "CreateSite", type: :request do
  it "should create the new site with valid params" do
    expect(Site.find_by(uid: "example")).to be_nil

    expect do
      post sites_path, name: "www.example.com", uid: "example", recipient: "test@example.com"
      expect(response).to have_http_status(:ok)
    end.to change { Site.count }.by(1)
  end

  it "should not create the new site with missing name" do
    expect(Site.find_by(uid: "example")).to be_nil

    expect do
      post sites_path, uid: "example", recipient: "test@example.com"
      expect(response).to have_http_status(:unprocessable_entity)
    end.not_to change { Site.count }
  end

  it "should not create the new site with missing uid" do
    expect do
      post sites_path, name: "www.example.com", recipient: "test@example.com"
      expect(response).to have_http_status(:unprocessable_entity)
    end.not_to change { Site.count }
  end

  it "should not create the new site with repeated uid" do
    site = create(:site)

    expect do
      post sites_path, name: "www.example.com", uid: site.uid, recipient: "test@example.com"
      expect(response).to have_http_status(:unprocessable_entity)
    end.not_to change { Site.count }
  end

  it "should not create the new site with missing recipient" do
    expect(Site.find_by(uid: "example")).to be_nil

    expect do
      post sites_path, name: "www.example.com", uid: "example"
      expect(response).to have_http_status(:unprocessable_entity)
    end.not_to change { Site.count }
  end
end
