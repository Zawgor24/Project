# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :title, :body, presence: true
  validates :title, length: { maximum: 20 }
end
