# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  alias update?  profile_owner?
  alias destroy? profile_owner?
end
