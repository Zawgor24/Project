# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  alias update?  manager_or_owner?
  alias destroy? manager_or_owner?
end
