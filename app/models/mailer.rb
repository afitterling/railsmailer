class Mailer < ActiveRecord::Base
  enum authentication: [:plain, :login, :cram_md5]
  attr_encrypted :password, key: Rails.configuration.encryption_key

  validates :uid, presence: true, uniqueness: true

  def action_mailer_config
    output = {}

    output[:address]              = address unless address.nil?
    output[:port]                 = port unless port.nil?
    output[:domain]               = domain unless domain.nil?
    output[:user_name]            = user_name unless user_name.nil?
    output[:password]             = password unless password.nil?
    output[:authentication]       = authentication.to_sym unless authentication.nil?
    output[:enable_starttls_auto] = enable_starttls_auto unless enable_starttls_auto.nil?
    output[:openssl_verify_mode]  = openssl_verify_mode unless openssl_verify_mode.nil?

    output
  end
end
