# frozen_string_literal: true

class PhoneVerificationsControllerPolicy < ApplicationPolicy
  alias create? phone_number?
end
