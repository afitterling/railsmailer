require 'rails_helper'

RSpec.describe Site, type: :model do
  before(:each) do
    @site = create(:site)
  end

  describe "default factory object" do
    it "should be valid" do
      expect(@site).to be_valid
    end
  end

  describe "name" do
    it "should be present" do
      @site.name = ''
      expect(@site).not_to be_valid
    end
  end

  describe "uid" do
    it "should be present" do
      @site.uid = ''
      expect(@site).not_to be_valid
    end

    it "should be unique" do
      other_site = build(:site)
      other_site.uid = @site.uid
      expect(other_site).not_to be_valid
    end
  end

  describe "recipient" do
    it "should be present" do
      @site.recipient = ''
      expect(@site).not_to be_valid
    end
  end
end
