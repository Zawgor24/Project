# frozen_string_literal: true

module UsersPhoneService
  def self.save(user, phone, code)
    user.update(phone_number: phone, country_code: code)
  end

  def self.delete_number(user)
    user.update(phone_number: nil, country_code: nil)
  end
end
