# frozen_string_literal: true

module OmniauthMacros
  def valid_facebook_login_setup
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      Faker::Omniauth.facebook
    )
  end

  def facebook_login_failure
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  end
end
