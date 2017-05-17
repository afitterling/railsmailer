require 'rails_helper'

RSpec.describe Device, type: :model do
  before(:each) do
    @device = Device.create!
    @tokens = (0..4).map do |seq|
      @device.device_access_tokens.create!(sequence: seq)
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
end
