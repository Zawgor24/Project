# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    title { Faker::Hacker.noun }
    body { Faker::Hacker.say_something_smart }
  end
end
