# frozen_string_literal: true

class News < ApplicationRecord
  belongs_to :category

  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :body, presence: true
  validates :title, length: { maximum: 20 }
end
