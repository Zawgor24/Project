# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :posts, dependent: :nullify
  has_many :news, dependent: :nullify

  validates :name, presence: true
end
