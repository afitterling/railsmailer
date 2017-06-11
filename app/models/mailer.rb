class Mailer < ActiveRecord::Base
  enum authentication: [:plain, :login, :cram_md5]
  attr_encrypted :password, key: Rails.configuration.encryption_key
end
