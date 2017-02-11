class AccessToken < ActiveRecord::Base
  belongs_to :user

  after_initialize do |access_token|
    access_token.token = SecureRandom.uuid unless access_token.token
  end
end
