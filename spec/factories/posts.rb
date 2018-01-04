# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Hacker.abbreviation }
    body { Faker::Hacker.say_something_smart }
    avatar { Faker::Avatar.image }
    category nil
    user nil
  end
end
