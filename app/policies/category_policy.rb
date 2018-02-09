# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  alias create?  manager?
  alias update?  manager?
  alias destroy? manager?
end
