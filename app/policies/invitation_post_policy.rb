# frozen_string_literal: true

class InvitationPostPolicy < ApplicationPolicy
  alias update?  manager_or_owner?
  alias destroy? manager_or_owner?
end
