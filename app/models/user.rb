# frozen_string_literal: true

class User < ApplicationRecord
  MINIMUM_AGE = 6

  acts_as_paranoid

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  enum sex: %i[male female]

  has_many :articles, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :info, length: { maximum: 256 }

  validate :birthday_more_that_current_date,
    :user_older_than_minimum_age, if: -> { birthday.present? }

  mount_uploader :avatar, ImageUploader

  private

  def birthday_more_that_current_date
    if birthday > Time.zone.now
      errors.add(:birthday, "can't be greater than current date")
    end
  end

  def user_older_than_minimum_age
    if birthday > MINIMUM_AGE.years.ago
      errors.add(:birthday, "user must be older than #{MINIMUM_AGE} years old")
    end
  end
end
