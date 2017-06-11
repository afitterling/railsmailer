require 'rails_helper'

RSpec.describe Mailer, type: :model do
  before(:each) do
    @mailer = create(:mailer)
  end

  describe "default factory object" do
    it "should be valid" do
      expect(@mailer).to be_valid
    end
  end

  describe "authentication" do
    it "should accept the specified symbols" do
      [:plain, :login, :cram_md5].each do |sym|
        @mailer.authentication = sym
        @mailer.save!
        @mailer.reload
        expect(@mailer.authentication).to eq sym.to_s
      end
    end

    it "can be initialized with strings" do
      %w(plain login cram_md5).each do |sym|
        mailer = create(:mailer, authentication: sym)
        mailer.reload
        expect(mailer.authentication).to eq sym
      end
    end
  end

  describe "password" do
    it "accessors should exist" do
      expect(@mailer).to respond_to :password
      expect(@mailer).to respond_to :password=
    end

    it "should update encrypted_password when set" do
      expect(@mailer.encrypted_password).to be_nil
      expect(@mailer.password).to be_nil

      @mailer.password = "foobar123"

      expect(@mailer.encrypted_password).not_to be_nil
      expect(@mailer.password).not_to be_nil
    end

    it "should decrypt encrypted_password" do
      plaintext_password = "hello_world"
      @mailer = create(:mailer, password: plaintext_password)
      # @mailer.password = plaintext_password
      # @mailer.save!

      reloaded_mailer = Mailer.find(@mailer.id)
      expect(reloaded_mailer.password).to eq plaintext_password
    end

    it "should not be stored in plaintext in the database" do
      plaintext_password = "hello_world"
      @mailer = create(:mailer, password: plaintext_password)

      reloaded_mailer = Mailer.find(@mailer.id)
      reloaded_mailer.attributes.each do |_, value|
        expect(value).not_to eq plaintext_password
      end
    end
  end
end
