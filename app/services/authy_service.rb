# frozen_string_literal: true

module AuthyService
  def self.start(user, method)
    authy_verification.start(
      via: method,
      country_code: user.country_code,
      phone_number: user.phone_number
    )
  end

  def self.check(user, code)
    authy_verification.check(
      verification_code: code,
      country_code: user.country_code,
      phone_number: user.phone_number
    )
  end

  def self.authy_verification
    Authy::PhoneVerification
  end
end
