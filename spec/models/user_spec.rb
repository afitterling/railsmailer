require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user)
  end

  describe "default factory object" do
    it "should be valid" do
      expect(@user).to be_valid
    end
  end

  describe "email" do
    it "should not be empty" do
      @user.email = ""
      expect(@user).not_to be_valid
    end

    it "should not be nil" do
      @user.email = nil
      expect(@user).not_to be_valid
    end
  end
end
