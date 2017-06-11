require 'rails_helper'

RSpec.describe DeviceAccessToken, type: :model do
  before(:each) do
    @device = create(:device)
    @token1 = create(:device_access_token, device: @device, sequence: 1)
    @token2 = create(:device_access_token, device: @device, sequence: 2)
  end

  describe "New object" do
    it "should have a default token" do
      access_token = DeviceAccessToken.new
      expect(access_token).not_to be_nil
    end
  end

  describe "consume" do
    it "should update device last_used_key_sequence" do
      @token1.consume
      @device.reload
      expect(@device.last_used_key_sequence).to eq @token1.sequence

      @token2.consume
      @device.reload
      expect(@device.last_used_key_sequence).to eq @token2.sequence
    end
  end
end
