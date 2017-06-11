require 'rails_helper'

RSpec.describe Device, type: :model do
  before(:each) do
    @device = create(:device)
    @tokens = (0..4).map { |seq| create(:device_access_token, device: @device, sequence: seq) }
  end

  describe "default factory object" do
    it "should be valid" do
      expect(@device).to be_valid
    end
  end

  describe "user" do
    it "should be accessible through accessor method" do
      expect(@device).to respond_to :user
    end
  end

  describe "current_valid_token" do
    it "should return the current valid token" do
      @tokens.each do |token|
        expect(@device.current_valid_token).to eq token
        token.consume
      end
    end

    it "should wrap around" do
      @tokens.last.consume
      expect(@device.current_valid_token).to eq @tokens.first
    end
  end

  describe "device access token" do
    it "should be accessible through accessor" do
      expect(@device).to respond_to :device_access_tokens
    end
  end

  describe "log data" do
    it "should be accessible through log data" do
      expect(@device).to respond_to :log_data
    end
  end
end
