class Mailer < ActiveRecord::Base
  enum authentication: [:plain, :login, :cram_md5]
  attr_encrypted :password, key: Rails.configuration.encryption_key

  def action_mailer_config
    {
      address: address,
      port: port,
      domain: domain,
      user_name: user_name,
      password: password,
      authentication: authentication.to_sym,
      enable_starttls_auto: enable_starttls_auto,
      openssl_verify_mode: openssl_verify_mode
    }
  end
end
