# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :body, presence: true
  validates :title, length: { maximum: 20 }
end
