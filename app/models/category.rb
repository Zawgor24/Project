# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :posts, dependent: :nullify

  scope :by_name, -> { order(name: :asc) }

  validates :name, presence: true

  has_ancestry
end
