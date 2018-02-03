# frozen_string_literal: true

class User < ApplicationRecord
  MINIMUM_AGE = 6

  enum sex: %i[male female]

  has_many :articles, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :invitation_posts, dependent: :destroy

  validates :info, length: { maximum: 256 }
  validates :first_name, :last_name, presence: true

  validate :birthday_more_that_current_date,
    :user_older_than_minimum_age, if: -> { birthday.present? }

  acts_as_follower

  acts_as_paranoid

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

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
