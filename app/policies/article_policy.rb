# frozen_string_literal: true

class ArticlePolicy < ApplicationPolicy
  alias create?  manager?
  alias update?  manager?
  alias destroy? manager?
end
