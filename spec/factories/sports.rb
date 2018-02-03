# frozen_string_literal: true

FactoryBot.define do
  factory :sport do
    name { Faker::Hacker.abbreviation }
    info { Faker::Hacker.say_something_smart }
    avatar { Faker::Avatar.image }
  end
end
